(*12 Beginner Questions*)

(*Q. Tail of a List*)
(*Solution*)
let rec last = function
| [] -> None
| [x] -> Some x
| h::t -> last t;;

(*Q. Last Two Elements of a List*)
(*Solution*)
let rec last_two = function
| [] -> None
| [x;y] -> Some(x,y)
| h::t -> last_two t;;

(*Q. N'th Element of a List*)
(*Solution*)
let at idx lst =
  let rec helper idx cnt = function
  | h::t -> if idx=cnt then Some h else helper idx (cnt+1) t
  | [] -> None
  in helper idx 0 lst;;

(*Q. Length of A list*)
(*Solution*)
let rec length = function
| [] -> 0
| h::t -> 1 + length t;;

(*Q. Reverse a list*)
(*Solution*)
let rev lst =
  let rec helper acc = function
  | [] -> acc
  | h::t -> helper (h::acc) t in
  helper [] lst;;

(*Q. Palindrome*)
(*Solution*)
let is_palindrome lst = List.rev lst = lst

(*Q. Run-Length Encoding *)
(*Solution*)
let encode lst =
  let rec helper cnt acc = function
  | [] -> []
  | [x] -> (cnt+1,x)::acc
  | first::(second::_ as t) -> if first = second then helper (cnt + 1) acc t 
  else helper 0 ((cnt+1,first)::acc) t 
  in List.rev (helper 0 [] lst);;

(*Q. Modified Run-Length Encoding *)
(*Solution*)
type 'a rle = 
  | One of 'a
  | Many of int * 'a

let encode lst = 
  let helper cnt el = 
    match cnt with
    | 1 -> One el    
    | _ -> Many(cnt,el)
  in
  let rec encoder cnt acc = function
  | [] -> []
  | [x] -> ((helper (cnt+1) x)::acc)
  | fst :: (scnd ::_ as tail) ->
      if fst = scnd then encoder (cnt+1) acc tail
      else encoder 0 ((helper (cnt+1) fst)::acc)tail
    in List.rev (encoder 0 [] lst);;
    
(*Q. Duplicate the Elements of a List *)
(*Solution*)
let duplicate lst = 
  let rec helper acc = function
  | [] -> acc
  | h::t -> helper (h::h::acc) t
in List.rev (helper [] lst);;

(*Q. Split a List Into Two Parts; The Length of the First Part Is Given *)
(*Solution*)
let split lst n =
  let rec helper idx acc = function
  | [] -> (List.rev acc,[])
  | h::t as l -> if idx = 0 then List.rev acc, l else helper (idx-1) (h::acc) t
in helper n [] lst;;

(*Q. Remove the K'th Element From a List *)
(*Solution*)
let rec remove_at n = function
| [] -> []
| h::t -> if n = 0 then t else h::remove_at(n-1) t;;

(*Q. Remove the K'th Element From a List *)
(*Solution*)
type 'a binary_tree = 
| Empty
| Node of int * 'a binary_tree * 'a binary_tree;;

let rec count_leaves = function
| Empty -> 0
| Node (_,Empty,Empty) -> 1
| Node (_,l,r) -> count_leaves l + count_leaves r

(*6 Intermediate Questions*)

(*Q. Flatten a List *)
(*Solution*)
type 'a node = 
| One of 'a 
| Many of 'a node list;;

let flatten lst = 
  let rec helper acc = function
  | [] -> acc
  | One x::t -> helper (x::acc) t
  | Many x::t -> helper (helper acc x) t
in List.rev ( helper [] lst);;

(*Q. Eliminate Duplicates *)
(*Solution*)
let rec compress = function
| a::(b::_ as tail) -> if a =b then compress tail else a::compress tail
| remaining -> remaining;;

(*Q. Pack Consecutive Duplicates *)
(*Solution*)
let pack lst = 
  let rec helper current acc = function
  | [] -> []
  | [x] ->(x::current) :: acc
  | a::(b::_ as t) -> 
      if a = b then helper (a::current) acc t
      else helper [] ((a::current)::acc) t in
    List.rev (helper [] [] lst);;

(*Q. Replicate the Elements of a List a Given Number of Times *)
(*Solution*)
let replicate lst num= 
  let rec helper idx num acc lst = match lst with
  | [] -> acc
  | h::t -> if idx = num then helper 1 num (h::acc) t else helper (idx+1) num (h::acc) lst
  in List.rev (helper 1 num [] lst);;

(*Q. Drop Every N'th Element From a List *)
(*Solution*)
let drop lst num = 
  let rec helper idx num acc= function
  | [] -> acc
  | h::t -> if idx = num then helper 1 num acc t else helper (idx+1) num (h::acc) t
in List.rev (helper 1 num [] lst)

(*Q. Extract a Slice From a List *)
(*Solution*)
let slice lst st en = 
  let rec helper idx acc st en = function
  | [] -> acc
  | h::t when idx>=st -> if idx<=en then helper (idx+1) (h::acc) st en t else acc
  | h::t when idx<st -> helper (idx+1) acc st en t
  | _ -> acc
in List.rev (helper 0 [] st en lst)

(* 1 Advanced Question*)
(*Q. Layout a Binary Tree (3) *)
(*Solution*)
type 'a tree =
  | Empty
  | Node of ('a * int * int) * 'a tree * 'a tree
let layout_binary_tree_3 =
  let rec translate_x d = function
    | Empty -> Empty
    | Node ((v, x, y), l, r) ->
        Node ((v, x + d, y), translate_x d l, translate_x d r)
  in
  let rec dist lr rl = match lr, rl with
    | lrx :: ltl, rlx :: rtl -> max (lrx - rlx) (dist ltl rtl)
    | [], _ | _, [] -> 0
  in
  let rec merge_profiles p1 p2 = match p1, p2 with
    | x1 :: tl1, _ :: tl2 -> x1 :: merge_profiles tl1 tl2
    | [], _ -> p2
    | _, [] -> p1
  in
  let rec layout depth = function
    | Empty -> ([], Empty, [])
    | Node (v, l, r) ->
        let (ll, l', lr) = layout (depth + 1) l in
        let (rl, r', rr) = layout (depth + 1) r in
        let d = 1 + dist lr rl / 2 in
        let ll = List.map (fun x -> x - d) ll
        and lr = List.map (fun x -> x - d) lr
        and rl = List.map ((+) d) rl
        and rr = List.map ((+) d) rr in
        (0 :: merge_profiles ll rl,
         Node ((v, 0, depth), translate_x (-d) l', translate_x d r'),
         0 :: merge_profiles rr lr)
  in
  fun t ->
    let (l, t', _) = layout 1 t in
    let x_min = List.fold_left min 0 l in
    translate_x (1 - x_min) t'
