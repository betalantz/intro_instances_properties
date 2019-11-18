- launch `irb`
- create instances of String objects with same string values
- call `.object_id` on them to illustrate they are individual instances
`"hello world"`
`str = _`
`str.object_id`
`another_string = "hello world"`
`another_string.object_id`
- Ruby is pure and every expression has to return an object
- "hello world" is an expression until we hit enter, then Ruby must return an object
- Show object primitives
`String.new`
`Array.new`
`Hash.new`
`Integer.new`
- oops, we can create new integers, but we can show that they are static objects
`8.object_id`
`8.object_id`

