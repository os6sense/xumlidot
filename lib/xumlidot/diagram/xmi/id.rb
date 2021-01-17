# frozen_string_literal: true

require 'securerandom'

module Xumlidot
  class ID
    class << self
      # rubocop:disable Layout/LineLength
      PREGENERATED = %w[ 915803defa2bd0509fc1ff7a652081d4 e891fc71118502b95030b5e15d887622 2cf60373a8305b3f64bb93a5fa0e786c 35cd5b04a0ab4542aede1e37046fab5e
                         e1521c43130d064474e1585be1d69c6f 59975b5d607a197e676e2534e3dce454 9e52022530441f1688dfab381bba4069 f84f7b576ba1ab5929b4208cebfe7935
                         37e5d86bb891a70011261ad861118a73 09646c77f8dfd088487c91f75c387a4c 9a064273fb75db2d41ad146063940862 ecc9ae948a23543ad23e61b0f907ae6b
                         b922777242d6e4d182e979a19b6b8fd9 b7f1299975494da9811c061f008cacba c906375f1de4be9d3dd3ea56e7917ea6 4265f6134237c7d0c9a4f12b838d1849
                         2d75d4762aa997551f95c76ff23a1e52 fe32489778ddc04b5b2e29a69a25c44e 8e89af98ee73225cac65ade347f5d653 70668faf589fcdd1034db5e8e38c0b8c
                         5b4d3919edab18b46790dc2af405982e bb35181dc1d23696cb914287fb3073da 1adca3c4c42e345682e0abe24dee32fb 611e830b410e4216c80b5fb62f0f0d20
                         648b5d6b3d87b62a3fd34620c391c6e5 bd0747fa99c86e03dd6bbeec3989f859 52653ebf9f0c0930523f583ca3a54476 52e2bdc77cba152a5f8a1e7703893b13
                         08b98d56e4b3e9dd7415cd0174550e01 63de406c477145edb70df08e1fe3d3e9 93f7b64cbd8e96ac5b54e0b83cfef84b cae3e7e7fc79276237aecaf68ab1bdc3
                         d2bde85b6c67f2c4e4f21f4eb24a9e11 b6239715d7b6dfbe845bf6218ffa9267 d018d840347248a3da9989cd56f10532 1fc72578fa0f6820991a2068aac595b0
                         f200b2bf3d28ce99cadeb505fe2a13f9 aba7ec911338260e448768655f9f7f62 e5019785cc3b2db9866887002aab0e82 a9490aac41fa641bf17595f5adc014e2
                         85917936118146692ec4ebaff9bffa25 13fe8089229ff0a7a824a11683e1afa4 8f4dcf8694457f5d09b69513034eb896 aa841e2dda7b46f397dfee83ebebfcb3
                         e84c823e04f190a46b92c7e96d39d802 8dc5d1471bda113d37134e6e457be7f3 ee0989ea42bd2a2e06b0b923bc27aac7 b21b9efefa95229940367caa25d7c7b6
                         7f32d97647fa4d3bb1cb0f8842f6280c 65864053fcd398271fd0482e4b8d6291 22c52a000c617293244d2346679bbcc7 f745cfcd9617f0ee9e8b7a609ccce424
                         85ee520fa2e905d454ccdbf94d789e81 f260df13675880d30ff85dd6713b3df8 afdbe21f7540febe19e2dd2efb1770fe 9c6e6b915115f94f74777e1fe3683805
                         8517f315cc89778e32d62b0e2ee0c01e 2303ed4f97dd09d24427400e3ed9dbaf 72549f0fe322198493927ff113bb9841 c27b2914926e6c8c7406199b0532ba00
                         79940b95278e119378da6e15eea86a90 cd3ee7977ead372f732a8c586ea566a7 ea6370883b3de89a8b38a03c1ec9d591 92ed3a3d54ac7c28e7544ea22f6bfe97
                         8c2302bf6185908b24798f359a2e4838 bef733b51d12963d596f5ecfd5197201 3fa6ac50361036266b73bca0ad3dee57 a5545b87d99a3b7c9533085498ff460e
                         dc3115e7ced845fc6303b2b294a42437 027b8863405ce601db60d685af987dee 71ac366b83d49ca62c3f7c0c7c101f43 6647027529522180e0ae96a176e5766d
                         22e2726ab1b3df71e314f8145180f1c8 b800ccd5d685adac614624ffd5abb098 6c395e62f19d0f5b04f7cea5dd616a24 e2bbe604833cc15c393450d215008306
                         7fa0acb9786d57b2ef4d9027f6cc7992 73d5302aedef54fb51cd08173c1f1829 01cef3c8b0d5ef6cae8574d1a5044b2b c695a6a12c418bb56699b2f5c6559da3
                         a14c60d2210dfea6e625208b72aa79e9 1c60dc02eece351995820d7436e7752e d2a2b30eecceb9f453697103b01b203a 3ae847a28c2248460a37e24686860479
                         354982e26fd1da65403c9e70866e14f7 66485373131b4d5e02261f9d085be072 2e3e154c3ec06e401f48c7f444583d45 e57c33100b8f66813ee9265e4f023e03
                         5afa58ca1c74f449d1b18cc3cb39b19f d5775ea87353bb12f31318533ed17382 c55778698f7c896c6f7e1a35f8698a06 178d5cdabad7e9f82f326a9ebbd01737
                         31cf106e33c94b139f8c8c4820b46524 50a49cf6d0b9bedcbcef845917889a62 cc8aa4100a6f3855df3518a0a4474b74 c98c57ab3db339c74d44d6da5b2e0e62
                         a04e46e4a1f5fea64b3a47a3cc8ca0de 750156c36b6990f2a4763949775ea6a1 423cb15b7efee4800449579ce561a58e 424041648b3414d67743957b9e2ad66c ].freeze
      # rubocop:enable Layout/LineLength

      def reset
        @fixed = nil
      end

      def fixed
        @fixed ||= PREGENERATED.dup
      end
    end
  end

  class Diagram
    class Xmi
      # Helper - everything needs an id and these ids need to be used in the
      # Element section
      module ID
        def id
          @_id ||= new_id
        end

        def force_id(id)
          @_id = id
        end

        def gen_id
          @gen_id ||= "#{new_id[0..5]}.#{new_id[0..5]}".upcase
        end

        def association_id
          @association_id ||= "#{new_id[0..5]}.#{new_id[0..5]}".upcase
        end

        def association_end_id
          @association_end_id ||= "#{new_id[0..5]}.#{new_id[0..5]}".upcase
        end

        private

        def new_id
          if ::Xumlidot::Options.use_debug_ids
            ::Xumlidot::ID.fixed.shift
          else
            SecureRandom.hex
          end
        end
      end
    end
  end
end
