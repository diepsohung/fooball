module Fooball
  class EasyHash
    def self.to_ostruct(hash)
      OpenStruct.new(hash.each_with_object({}) do |(key, value), memory|
        memory[key] = value.is_a?(Hash) ? to_ostruct(value) : value
      end)
    end

    def self.array_hash_to_ostruct(array)
      array.map { |hash| self.to_ostruct(hash) }
    end
  end
end
