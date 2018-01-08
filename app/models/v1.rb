# frozen_string_literal: true
module MyMeds
  class Component
    module Medicine
      class V1 < MyMeds::Component
        include Multiple
        param :hide_batch
        param :hide_dose_change
        param :show_remove

        attr_reader :indication_values

        component :company_product, Component::SingleChoice::V1, values: ->(_) {
          [
            [I18n.t("yes_no.y"), "y"],
            [I18n.t("yes_no.n"), "n"]
          ]
        }

        component :dates, Component::DateRange::V1, allow_future: false, allow_past: true, alternate_labels: true
        component :batch, Component::MedicationBatch::V1
        component :dose_changed, Component::SingleChoice::V1, values: ->(_) { DoseChange.options }
        component :dose_change_improved, Component::SingleChoice::V1, values: ->(_) { DoseChange.improved }
        component :dose_change_reverted, Component::SingleChoice::V1, values: ->(_) { DoseChange.reverted }
        component :dose_reversion_reoccurance, Component::SingleChoice::V1, values: ->(_) { DoseChange.reoccurance }

        component :indications, Component::IndicationPicker::V1, values: lambda { |form|
          options = form.component.parent.indication_values.sort_by { |w, _, _| [w.downcase, w] }
          options << [I18n.t("other"), "other", {
            class: "m-toggle",
            data: { "toggle" => ".m-other-entry, .m-other-entry-remove" },
            other: true
          }]
          options
        }

        component :causality, Component::MedicineCausality::V1

        component :other_indications, Component::AdverseEventPicker::V1,
                  disable_remove_popup: true,
                  enable_meddra_list: lambda { CustomerConfigurationService.key("medicines.meddra_list_indications_enabled") }

        component :country, Component::CountrySelect::V1,
                  default: lambda { |form| form.component.parent.product_country(form.report.reporter_country, form.object["value"]) },
                  include_blank: false,
                  include_unknown: true

        component :formulation, Component::FormulationSelector::V1

        def show(opts = {})
          data = opts[:form].data
          report = opts[:form].report

          if (list = configured_indications(report)).present? && report.report_type == "psp" && data._name == "primary"
            @indication_values = list
          elsif data.has_key?("term") && data.has_key?("country")
            @indication_values = MedicineService.indication_values(data["term"]["name"].to_s, data["country"]["value"].to_s, report.language)
          elsif data.has_key?("term")
            @indication_values = MedicineService.indication_values(data["term"]["name"].to_s, nil, report.language)
          end
          super
        end

        def configured_indications(report)
          if report.site && (study = report.site.study)
            clinical_indications = study.clinical_indications.map { |name| [name, name, {}] }

            language = M3::Locale.language(report.language).downcase
            meddra_indications = study.indications.where(language: language).map { |i|
              [i.name, i.name, { data: { meddra_llt_code: i.code } }]
            }

            (clinical_indications + meddra_indications)
          else
            []
          end
        end

        def validate(report, data)
          #validate picker to fix data
          report.journey.field("SuspectMedications::V1:#{data.path}").component.validate(report, data)
        end

        def fix_data(report, data)
          report.journey.field("SuspectMedications::V1:#{data.path}").component.fix_data(report, data)
        end

        def medication_picker(form)
          form.report.journey.field(form.path.gsub("MedicineEditable", "SuspectMedications"))
        end

        def product_country(reporter_country, product_country)
          product_country.present? ? product_country : reporter_country
        end

        def show_remove?(form)
          !study_drug?(form) && (Proc === self[:show_remove] ? self[:show_remove].call : self[:show_remove])
        end

        def show_edit?(form)
          !study_drug?(form) && CustomerConfigurationService.key("contact_centre.edit_enabled")
        end

        def show_causality?(form)
          CustomerConfigurationService.causality_enabled?(form.report.user_type) && form.report.adverse_event_names.present?
        end

        def allowed_fields(data)
          product = data.product_type.value.present? ? data.product_type.value : default_product
          sub_products = data.sub_types.value.present? ? data.sub_types.value : []

          MedicineService.fields_for(product, sub_products)
        end

        def show_country?(form)
          !study_drug?(form) && MedicineService.allow_purchase_country?
        end

        def term_name(form)
          if study_drug?(form)
            country = form.object.country.value == "unknown" ? I18n.t("unknown") : form.object.country.value
            name = form.object.term.name
            name += " (#{country})" if form.object.country.value.present?
            name
          else
            form.object.term.name
          end
        end

        def field_list(form)
          allowed_fields(form.data).reject { |field_name, _field| field_name == "country" }
        end

        def default_product
          CustomerConfigurationService.key("medicines")["fields"]["default_product"]
        end

        def self_report(form)
          self_reporting?(form.report["user_type"], form.report["who_affected.who.value"])
        end

        def study_drug?(form)
          form.data._name == "primary" && form.report.report_type == "psp" && StudyService.drugs(form.report).present?
        end
      end
    end
  end
end
