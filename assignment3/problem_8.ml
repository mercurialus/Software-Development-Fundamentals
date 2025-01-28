exception InvalidInput of string

let parse_int_list input_string =
  let is_digit ch = ch >= '0' && ch <= '9' in

  let rec string_to_int str i acc =
    if i < 0 then acc
    else if is_digit str.[i] then
      string_to_int str (i - 1) (acc * 10 + (Char.code str.[i] - Char.code '0'))
    else
      raise (InvalidInput ("Invalid character in input: " ^ String.make 1 str.[i]))
  in


  let rec split_on_comma str i acc current =
    if i = String.length str then
      if current <> "" then current :: acc else acc
    else if str.[i] = ',' then
      if current = "" then
        raise (InvalidInput "Misplaced or multiple commas detected")
      else
        split_on_comma str (i + 1) (current :: acc) ""
    else if is_digit str.[i] then
      split_on_comma str (i + 1) acc (current ^ String.make 1 str.[i])
    else
      raise (InvalidInput ("Invalid character in input: " ^ String.make 1 str.[i]))
  in

  let reversed_strings = split_on_comma input_string 0 [] "" in


  let rec convert_to_int_list strs acc =
    match strs with
    | [] -> List.rev acc
    | hd :: tl ->
      let number = string_to_int hd (String.length hd - 1) 0 in
      convert_to_int_list tl (number :: acc)
  in

  convert_to_int_list reversed_strings []
  
let () =
  try
    let input = "1,2,3,4" in
    let int_list = parse_int_list input in
    List.iter (fun x -> Printf.printf "%d\n" x) int_list
  with
  | InvalidInput msg -> Printf.printf "Error: %s\n" msg
