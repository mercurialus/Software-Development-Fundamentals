(*1.) solution function using pattern matching and recursive function definition *)
let solution lst =
  let rec take n lst =
  match n,lst with
  | 0,_ | _,[] -> ([],lst)
  |n,h::t ->
  let (left,right) = take (n-1) t in (h::left,right)
  in
  let rec len lst = match lst with
  | [] -> 0
  | h::t -> 1 + len t
  in let length = (len lst + 1) /2
  in take length lst ;;
(*utop -> val solution : 'a list -> 'a list * 'a list = <fun>*)
(*Input -> solution ([1;2;3;4;5;6;7;8;9]);; *)
(*output ->  int list * int list = ([1; 2; 3; 4; 5], [6; 7; 8; 9]) *)