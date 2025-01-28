(*2. Implement function solution*)
let rec solution func lst =
  match lst with
  | [] -> []
  | h::t -> match func h with
  | Some y -> y :: solution func t
  | None -> solution func t;;
(*utop -> val solution : ('a -> 'b option) -> 'a list -> 'b list = <fun>*)
(*Input -> 
  let divide_by_three x =
  if x mod 3 = 0 then Some (x / 3)
  else None;;
  let lst = [1; 2; 3; 4; 5; 6];;
*)
(*output ->  int list = [1; 2]*)