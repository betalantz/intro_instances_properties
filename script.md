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
- Ruby is pure and every expression has to return an object
- "hello world" is an expression until we hit enter, then Ruby must return an object
- Show object primitives
```ruby
String.new
Array.new
Hash.new
Integer.new
```
- oops, we can create new integers, but we can show that they are static objects
```ruby
8.object_id
8.object_id
```

_002_classes_and_instances.rb_
```ruby
class Dog
end
```

_irb_
- Dog is a constant (capitalized, different kind of variable)
- we can accomplish the same with with
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
snoopy.new
snoopy.methods
```
(dot notation: term on left is *receiver* `snoopy`, and term on right is *sender* which sends a message `methods` to the receiver)
"Snoopy, tell me your methods."
- Snoopy can do a lot right out of the box because it is an object, so it inherits a base set of functionality which all Ruby objects share (nothing specific to Dog yet)
- We have already use `.object_id` to see where an object lives in memory
- We want to make our dogs be able to do things that no other objects can do
- done through adding methods

_002_classes_and_instances.rb_
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
```
Can I require all Dogs in general to bark?
`Dog.bark`
No (throws error)

