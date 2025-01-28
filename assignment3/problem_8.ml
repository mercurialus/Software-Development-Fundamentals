exception InvalidInput of string

let is_num (ch: char) : bool = ch >= '0' && ch <= '9'
let comma = ','


let rec split_delim (delimiter: char) (s: string) (idx: int): string list =
  let len = String.length s in
  let rec helper delimiter s idx current_substring result =
    if idx >= len then
      List.rev (current_substring :: result)
    else
      match s.[idx] with
      | c when c = delimiter ->
          helper delimiter s (idx + 1) "" (current_substring :: result)
      | c ->
          helper delimiter s (idx + 1) (current_substring ^ Char.escaped c) result
  in
  helper delimiter s idx "" []


let rec stringlist_to_intlist (lst1: string list) =
  match lst1 with
  | [] -> []
  | h :: t ->
      if h = "" then raise (InvalidInput "Wrong commas in the input")
      else (int_of_string h) :: (stringlist_to_intlist t)


let parse_string_to_int (s: string) : int list =
  let parts = split_delim comma s 0 in
  stringlist_to_intlist parts

let solution  =
  print_endline "Please enter the string: ";
  try
    let input = read_line () in
    Printf.printf "Input: %s\n" input;
    let output = parse_string_to_int input in
    let output_str = String.concat "; " (List.map string_of_int output) in
    Printf.printf "Output: [%s]\n" output_str;
    output 
  with
  | InvalidInput msg ->
      Printf.printf "Error: %s\n" msg;
      []
  | Failure _ ->
      Printf.printf "Error: Invalid input, unable to parse integers\n";
      []
