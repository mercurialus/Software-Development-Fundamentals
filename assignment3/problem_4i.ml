let rec solution lst =
  match lst with
  | [] -> []
  | hd::tl -> let rec append lst1 lst2 =
  match lst1 with
  | [] -> lst2
  | h::t -> h::(append t lst2) in
  append hd (solution tl);;
  (*input -> [1;2;3];[4;5];[6;7;8;9;10];;*)
  (*output -> - : int list = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]*)