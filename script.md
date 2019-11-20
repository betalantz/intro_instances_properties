# Objects in Ruby

- launch `irb`
- create instances of String objects with same string values
- call `.object_id` on them to illustrate they are individual instances
```ruby
"hello world"
str = _
str.object_id
another_string = "hello world"
another_string.object_id
```
- Ruby is a purely object oriented language and every expression has to return an object
- "hello world" is an expression until we hit enter, then Ruby must return an object
- Show object primitives
```ruby
String.new
Array.new
Hash.new
Integer.new
```
- oops, we can't create new integers, but we can show that they are static objects
```ruby
8.object_id
8.object_id
```
# Classes and Instances

_002_classes_and_instances.rb_
```ruby
class Dog
end
```

_irb_
- Dog is a constant (capitalized, different kind of variable)
- we can accomplish the same thing with
`Dog = Class.new` (this is kinda meta and we don't need to worry about it now)
- now I can bring new dogs to life
```ruby
fido = Dog.new
rover = Dog.new
```
- what kind of properties and/or behaviors would I want to program my dogs to have?

Classes are 2 things:
- factory: my class can spawn new, individual (instances of) dogs `fido = Dog.new`  
- blueprint: they define what properties and behaviors dog instances can have

Instances: individual objects derived from a class
- what behaviors does an instance have?  What can it do?
```ruby
snoopy= Dog.new
snoopy.methods
```
(dot notation: term on left is *receiver* `snoopy`, and term on right is *sender* which sends a message `methods` to the receiver)
"Snoopy, tell me your methods."
- Snoopy can do a lot right out of the box because it is an object, so it inherits a base set of functionality which all Ruby objects share (nothing specific to Dog yet)
- We have already used `.object_id` to see where an object lives in memory
- We want to make our dogs be able to do things that no other objects can do
- done through adding methods

_003_instance_methods.rb_
```ruby
# class definition
class Dog
    #Body of the Dog class
    def bark #Instance Method
        puts "Woof!!"
    end

end
```
Instance method: the receiver of the `bark` behavior will be individual `instances` of `Dog`s

- copy class to `irb`
- recreate `fido` and `snoopy` instances
- call `.methods` on both to show they both now possess `:bark`
- elicit the behavior
```ruby
fido.bark
snoopy.bark
Dog.bark
```
Can I require all Dogs in general to bark?
- No (throws error) but this is logical
- barking is something individual dogs do
- sending `bark` to the entire class would be like programming a universal dog whistle which simultaneously causes all created dogs to bark (there will be a way to program something like this, but that comes later)

# Properties of Objects
- we've been creating dog instances from our class, like `fido = Dog.new`
- `fido` is just a variable name
- I could just as well write `x = Dog.new`
- variables are like labels we as programmers put on objects so we can refer to and manipulate them
- variables don't inherently _mean_ anything to Ruby, they're just labels
- our `fido` Dog object does not yet have the property of a name "Fido"
- our Dogs don't even have the concept yet of having a name property (or characteristic)
- Ruby can't infer "oh, the programmer created a Dog object assigned to the variable `fido` so maybe I should give that object a `fido` property"

_004_attributes_and_instances.rb_
```ruby
class Dog
    def bark 
        puts "Woof!!"
    end
end

foo = Dog.new
# How do I give dog "x" a name?

# Methods = Behaviors
# Variables = Data

foo.bark #=> "Woof!!"
# start with the code I wish I had--pseudocode
foo.name = "FooDog"
foo.name #=> "FooDog"

```
(Good definition of Object: all of the data and all of the behaviors needed in order to accomplish a job)

- since all we can do with classes is give them methods, whatever we need to do to give dogs names, it will be through methods
- `foo.name=` is still calling a method on an object
- in Ruby, we are _*always*_ calling methods on objects

_irb_
_[I feel like the next 7 lines could be edited out. Interesting, but possibly confusing to beginners.]_
```ruby
1 + 1
# What's really happening is:
1.+(1)
# Where the first 1 is the receiver of the + method with an argument of 1
puts "Woof!"
# puts is still a method call on an implicit receiver
# in this case, the object is hidden (Kernel)

# now, with Dog class and fido instance still in memory
fido.name = "Fido"
```

- check the error carefully
- it's telling us we need to define a method called `name=`

_004_attributes_and_instances.rb_
```ruby
# add this to Dog class
def name=
    puts "You've called name="
end
```
- try running in irb and calling `fido.name = "Fido"` again
- now it's an ArgumentError
- so fix our method
```ruby
# add this to Dog class
def name=(this_dogs_name)
    puts "You're naming this dog: #{this_dogs_name}"
end
```
- and run in irb
- we've just written a "writer" or a "setter" method, as the purpose of the method is to set data on our object
    - you don't have to remember that now, we'll cover in depth later
- now we need our "reader" (or "getter") method
- we're going to run into an interesting problem here

```ruby
def name=(this_dogs_name)
    # Write the property of a dog's name
    puts "You're naming this dog: #{this_dogs_name}"
    the_name = this_dogs_name
end

def name
    # Read the property of a dog's name
    return the_name
end
```
- It seems like we should be able to take the string passed into our setter as `this_dogs_name` and assign it to a local variable `the_name`, then define another method which simply returns the value of `the_name`
- Alarm bells should be going off
- local variables: begin with lowercase, limited to method scope
- Can you anticipate/predict the error this will raise?
_in irb_
```ruby
foo.name
```
`undefined local variable 'the_name'`

- we're running up against the limitation of the most restricted, limited scope: local scope
- let's go to the opposite extreme of the variable with the most expansive scope, global variables
- CAVEAT: you will 99.9% NEVER use global variables in your Ruby code, reserved for the Interpreter only
- if you don't know what that means, you shouldn't use them
- but we'll illustrate now why not
_004_attributes_and_instances.rb_
```ruby
class Dog
    #Body of the Dog class
    def bark #Instance Method
        puts "Woof!!"
    end

    def name=(this_dogs_name) # Scope Gate
        # The Setter Method's Scope
        # Write the property of a dog's name
        # puts "You're naming this dog: #{this_dogs_name}"
        $the_name = this_dogs_name
    end

    def name  # Scope Gate
        # The Getter Method's Scope
        # Read the property of a dog's name
        return $the_name
    end

end
```
_can clear irb by relaunching and copying in Dog class_
```ruby
fido = Dog.new
fido.name= "Fido"
fido.name
snoopy = Dog.new
snoopy.name= "Snoopy"
snoopy.name
```
Hey, what's so bad about global variables? Looks good so far!

```ruby
fido.name
```
- Ooops, not our expected behavior
- there is only one global variable `$the_name` which all of our instances have access to
- value gets overwritten by each instance which reassigns it
- what we really need is a variable which is unique to each instance of a dog, but which is accessible by every method in that instance
- a variable whose scope is not just one method, but neither is it the entire program

```ruby
class Dog
    #Body of the Dog class
    def bark #Instance Method
        puts "Woof!!"
    end

    def name=(this_dogs_name) # Scope Gate
        # The Setter Method's Scope
        # Write the property of a dog's name
        # puts "You're naming this dog: #{this_dogs_name}"
        @the_name = this_dogs_name
    end

    def name  # Scope Gate
        # The Getter Method's Scope
        # Read the property of a dog's name
        return @the_name
    end

end
```
Instance variables: the scope is every individual instance of a class; as long as it is in an instance method, all instance variables are in scope across all instance methods
_run all of the above again in irb, first copying new version of class into irb_

```ruby
fido.name= "Fido"
fido.name
snoopy.name= "Snoopy"
snoopy.name
fido.name
fido
snoopy
```
- now we can see that our instance retain their unique name values
- Each instance of Dog has it's own copy of the `@the_name` variable with it's own unique value
```ruby
snoopy.the_name
```
- I can't just reach into an object and pull out it's properties directly
- I have to write methods that _*expose*_ these properties, i.e. make them accessible to the 'outside world'
- but it's not only Readers/Writers (Getters/Setters) that get to play with instance variables
```ruby
# add instance variable to #bark
    def bark #Instance Method
        puts "Woof!! #{@the_name}"
    end
fido.bark
snoopy.bark
```

Instance variables are a way to give properties to objects instantiated from a class
also called _internal state_ because the properties of an object are private until exposed

- NB: it's convention to name our getter and setter methods after the variables they access (because why be obtuse? programming is already hard enough) but it's not required by Ruby for the code to run/execute 

# Attr_accessor
_if there's time, this is a good place to quickly recap what's been covered so far_
- normalize `@the_name` to `@name`
- continue to add readers and writers for `@coat_color` and `@breed`

_004_attributes_and_instances.rb_
```ruby
class Dog
    def bark 
        puts "Woof!! #{@name}"
    end

    def name=(this_dogs_name) 
        @name = this_dogs_name
    end

    def name  
        return @name
    end

    def coat_color=(color)
        @coat_color = color
    end

    def coat_color
        @coat_color
    end  

    def breed=(breed)
        @breed = breed
    end

    def breed
        @breed
    end
end
```
- gets a little repetitive and boring, as we now know exactly what each reader/writer pair is going to do
- they're vanilla readers and writers

_implement in irb_
```ruby
fido.name = "Fido"
fido.coat_color = "gold"
fido.breed = "retriever"
fido
fido.name
fido.coat_color
fido.breed
```
- This is such a common pattern that Ruby gives us a shortcut to creating our vanilla readers and writers: `attr_accessor`
This is a macro--a method which creates other methods
- I'm showing the syntax here, that we pass an argument to attr_accessor as a symbol

_004_attributes_and_instances.rb_
```ruby
class Dog

    attr_accessor(:name) #=> No magic, only methods on objects
    # attr_accessor :name is equivalent to the code below
    # attr_accessor adds 2 instance methods to our objects, a reader and a writer.
    # Dog#name method for the reader, and Dog#name= for the writer.
    # These methods will read/write to an instance variable @name

    # def name=(name) 
    #     @name = name
    # end

    # def name  
    #     @name
    # end

    def bark 
        puts "Woof!! #{@name}"
    end

end
```
_implement the above in a fresh irb_

_add a new line `attr_accessor :breed`_
- How many methods get added? 2, Dog#breed and Dog#breed=
    - instance variables can be added 'on the fly' and don't have to be declared initially
- show multi-argument attr_accessor `attr_accessor :breed, :coat_color, :age, :gender`
- How many methods added now? 8

- but maybe there are properties that we don't want to change after a dog is born (after obj is instantiated)
- It doesn't make sense to be able to overwrite an instance's breed with a new breed, eg.
- so Ruby gives us separate attr_reader and attr_writer

```ruby
attr_accessor :coat_color, :age, :gender
attr_reader :breed
attr_writer :recent_meal
```
- How does a dog get a breed then to begin with if it only has a reader?
    - There's a way that I'll show you next

# Initialize

An object has a lifecycle: it's born, has events happen to it, and we can tap in to those events

_005_initialize.rb_
```ruby
class Dog
    attr_reader :name

end

fido = Dog.new
fido.name = "Fido" #=> NoMethod error, why?
# What I want to be able to do is pass the name as an argument at the moment a new dog is created
fido = Dog.new("Fido") #=> ArgumentError
```
- The moment in the lifecycle we're concerned with here is the moment a dog is born, i.e. the moment an object is *instantiated*, or *initialized*
- This is also going to answer the question of how we can give a dog a name if we only create a reader for that attribute
- Looking at the error message here tells us a lot: initialize got 1 argument when it takes 0
- The initialize method is a type of:
    - hook
    - callback
    - lifecycle event
- Whenever we call `new` on a class (whenever an object is 'born'), the class itself calls `initialize` on the new object

_005_initialize.rb_
```ruby
class Dog
    attr_reader :name

    def initialize # Hook / Callback / Lifecycle Event
        # Dog#initialize will automatically fire upon evocation of Dog.new
        puts "A new dog was just born!!!"
    end

end
```
_implement with `Dog.new` in irb_

- If I want `Dog.new("Fido")` to accept an argument, I just have to also give `initialize` an argument

```ruby
class Dog

    attr_reader :name

    def initialize(name) # Hook / Callback / Lifecycle Event
        # Dog#initialize will automatically fire upon evocation of Dog.new
        puts "A new dog was just born!!!"
        @name = name
    end

end
```
- Now `initialize` receives a value we'll locally call `name`, and we can assign that value to the instance variable `@name`
- Since `initialize` is an instance method, we have access to instance variables, like `@name` and I can cast the local variable into the instance variable, which I know can then be read.
- I know that `@name` is available because I've given `attr_reader` the symbol `:name` so according to Ruby conventions, I know there is already a reader method which exposes an instance variable `@name`
```ruby
def name
    @name
end
```
- So when I write my initialize method, I hook into these conventions, and should get my desired behavior

_demo in irb_
```ruby
fido = Dog.new #=> opposite ArgumentError
```
- Now I get the opposite type of error as before
- Because I gave  `initialize` and argument, I _must_ invoke the *constructor* with the same number of arguments (we call `Dog.new` a constructor because it constructs new objects for us)
- So I can no longer create a dog without supplying a name for a dog
```ruby
fido = Dog.new("Fido")
fido.name
fido.name = "Rover" #=> NoMethod Error
```
- So that's `initialize`
- we commonly use intialize to set properties on an object that we *don't* want to be able to change later in the object's lifecycle
- in that sense, `initialize` can be thought of as a single-use setter/writer, invoked upon object instantiation

- we can also program our `initialize` method to _*optionally*_ receive an argument when upon object instantiation

_005_initialize.rb_
```ruby
class Dog

    attr_reader :name

    def initialize(name = nil) # We can assign a default value to the incoming argument
        puts "A new dog was just born!!!"
        @name = name
        @birthday = Time.now
    end

end
```
- By setting a default value for the argument being received by `initialize`, we make it optional whether Dogs get created with a name or not
- If we don't pass any argument to `initialize`, the value of `@name` will be `nil`, but we can still instantiate objects
```ruby
fluffy = Dog.new
fluffy.name #=> nil
fluffy.name = "Fluffy" #=> NoMethod error
sparky = Dog.new("Sparky")
sparky.name #=> "Sparky"
```

_[I think it would be ok to end here if short on time; the following information is supplemental]_

- We can also set properties not passed in through the constructor

_005_initialize.rb_
```ruby
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
```
- Here, `age` acts like a kind of dynamic custom reader
- We've set `@born_on` as a static property assigned on object instantiation
- but we've added some logic to `#age` that makes it dynamic
```ruby
snoopy = Dog.new("Snoopy")
snoopy.age
snoopy.age
```
- Notice that `@born_on` is never exposed by any methods, so I only have access to it 'inside' of my object
- When I call methods on an object, I'm on the 'outside' and can only use the interfaces presented by the object to interact with it
- i.e. The only insight I have into the internal state of the object is through the methods I can invoke on the object and the properties they expose.


_This script is largely based on a video by Avi Flombaum, [Intro to Object Orientation (2/8/16)](https://www.youtube.com/watch?v=UysgBTrJoTc)_