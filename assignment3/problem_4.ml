let rec append lst1 lst2 =
  match lst1 with
  | [] -> lst2
  | h::t -> h::(append t lst2);;

 let rec solution_i lst =
    match lst with
    | [] -> []
    | hd::tl -> let rec append lst1 lst2 =
    match lst1 with
    | [] -> lst2
    | h::t -> h::(append t lst2) in
    append hd (solution_i tl);;
    (*input -> [1;2;3];[4;5];[6;7;8;9;10];;*)
    (*output -> - : int list = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]*)

  let solution_ii lst = 
    let rec helper acc lst = 
      match lst with
        | [] -> acc
        |  h::t -> helper (append acc h) t
    in helper [] lst;;

(*input -> flatten [[1;2;3];[4;5;6;7];[100;121;144]];;*)
 (*output -> - : int list = [1; 2; 3; 4; 5; 6; 7; 100; 121; 144]*)