type 'a tree =
  | Leaf
  | Node of 'a * 'a tree * 'a tree
let rec tree_map func t =
  match t with
  | Node(value, left, right) -> Node(func value, tree_map func left, tree_map func right)
  | Leaf -> Leaf;;
(*input ->
let t = Node(4,
Node(2,
Node(1, Leaf,Leaf),Node(3,Leaf,Leaf)),Node(5,Node(6,Leaf,Leaf),Node(7,Leaf,Leaf)));;
let multiply_with_two x = 2 * x;;
tree_map multiply_with_two t;;
*)
(*output -> Node (8, Node (4, Node (2, Leaf, Leaf), Node (6, Leaf, Leaf)),
 Node (10, Node (12, Leaf, Leaf), Node (14, Leaf, Leaf)))*)
