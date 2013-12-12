class Ribeye

  class BloomFilter

    attr_reader :name, :size

    def initialize(name, size, opts = {})
      @name = name
      @size = size
      @client = Ribeye.new(opts[:uri])
      @client.create(name, size) unless @client.exists(name)
    end

    def insert(value)
      @client.insert(name, value)
    end

    def check(value)
      @client.check(name, value)
    end

  end

end
