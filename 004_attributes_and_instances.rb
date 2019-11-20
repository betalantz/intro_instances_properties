class Dog

    attr_accessor(:name) #=> No magic, only methods on objects
    # attr_accessor :name is equivalent to the code below
    # attr_accessor adds 2 instance methods to our objects, a reader and a writer.
    # Dog#name method for the reader, and Dog#name= for the writer.
    # These methods with read/write to an instance variable @name

    # def name=(name) 
    #     @name = name
    # end

    # def name  
    #     @name
    # end
    attr_accessor :coat_color, :age, :gender
    attr_reader :breed
    attr_writer :recent_meal
    
    def bark 
        puts "Woof!! #{@name}"
    end

end