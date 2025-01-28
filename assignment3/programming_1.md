
For each of the following questions, write the required function, along with the outputs in the utop.



**Use the pattern matching over list and recursive function definitions**
Write a function split : 'a list -> ('a list * 'a list) that splits a list into two halves. If the list has an odd number of elements, the extra element should go into the first half.


**Read about option type and**
Implement a function filter_map : ('a -> 'b option) -> 'a list -> 'b list that applies a given function to each element of a list. If the function returns Some x, include x in the result; if it returns None, skip that element.



**Using the variant typing explained in the class**
Define a type for a binary tree, call it the type `a tree.
Write a function tree_map : ('a -> 'b) -> 'a tree -> 'b tree that maps a function over all the elements of the tree (Hint use pattern matching on the constructors of the data type)


**Recall the earlier homework to read about tail-recursion**
i) Implement a function flatten : 'a list list -> 'a list that concatenates a list of lists into a single list.
ii)  Change this function into a tail-recursive function. (I gave an exercise to read about tail-recursion)


**Recall the exception and error discussion**
Write a function safe_div : int -> int -> int option that performs integer division and returns None if the denominator is 0, or Some result otherwise.
Rewrite the same function using a try-with block



**Variant type and pattern matching**
Create a type shape to represent a Circle (with radius) and a Rectangle (with width and height). Write a function area : shape -> float that calculates the area of a shape.


**Read about how to define user-defined exceptions**
Write a function find_index : ('a -> bool) -> 'a list -> int that returns the index of the first element in a list satisfying a given predicate. Raise a custom exception NotFound if no such element exists, the exception should also return the index searched and the size of the list.


**Read about tuples and, and use the function int_of_string**
Write a function parse_int_list : string -> int list that takes a string of comma-separated integers (e.g., "1,2,3,4") and returns a list of integers. Handle invalid inputs (i.e. if the commas are misplaced or a non integer value) using a user defined exception.



