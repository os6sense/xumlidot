class Author < ActiveRecord::Base
  has_many :books

  def self.blah
  end

  def write()
  end

  def study_drug?(form)
    form.data._name == "primary" && form.report.report_type == "psp" && StudyService.drugs(form.report).present?
  end
end
