let rec append lst1 lst2 =
  match lst1 with
  | [] -> lst2
  | h::t -> h::(append t lst2);;

  let solution lst = 
    let rec helper acc lst = 
      match lst with
        | [] -> acc
        |  h::t -> helper (append acc h) t
    in helper [] lst;;

(*input -> flatten [[1;2;3];[4;5;6;7];[100;121;144]];;*)
 (*output -> - : int list = [1; 2; 3; 4; 5; 6; 7; 100; 121; 144]*)