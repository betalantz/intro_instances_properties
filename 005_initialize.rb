class Dog

    attr_reader :name

    def initialize(name) # Hook / Callback / Lifecycle Event
        # Dog#initialize will automatically fire upon evocation of Dog.new
        puts "A new dog was just born!!!"
        @name = name #Static Property
        @born_on = Time.now # Static Property
    end

    def age # Dynamic reader based on a static property
        Time.now - @born_on
    end

end