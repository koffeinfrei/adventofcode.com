use std::error::Error;
use std::fs::File;
use std::io::prelude::*;
use std::path::Path;

fn create_result(instructions: &mut Vec<i32>) {
    let mut i = 0;
    loop {
        let opcode = instructions[i];

        // add
        if opcode == 1 {
            let position_input1 = instructions[i + 1] as usize;
            let position_input2 = instructions[i + 2] as usize;
            let result = instructions[position_input1] + instructions[position_input2];
            let position_result = instructions[i + 3] as usize;
            instructions[position_result] = result;
        }
        // multiply
        else if opcode == 2 {
            let position_input1 = instructions[i + 1] as usize;
            let position_input2 = instructions[i + 2] as usize;
            let result = instructions[position_input1] * instructions[position_input2];
            let position_result = instructions[i + 3] as usize;
            instructions[position_result] = result;
        }
        // done
        else if opcode == 99 {
            break;
        }
        // error
        else {
            panic!("op code {} at position {} is not expected",
                   opcode, i);
        }

        if i >= instructions.len() {
            panic!("instructions sequence has been consumed, but halt opcode hasn't been consumed.");
        }

        // next instruction sequence
        i = i + 4;
    }
}

fn find_result(instructions: &Vec<i32>, expected_result: i32) -> (i32, i32) {
    for noun in 0..100 {
        for verb in 0..100 {
            let mut instructions_copy = instructions.clone();
            // adjust initial values
            instructions_copy[1] = noun;
            instructions_copy[2] = verb;
            create_result(&mut instructions_copy);

            if instructions_copy[0] == expected_result {
                return (noun, verb)
            }
        }
    }

    return (-1, -1);
}

fn main() {
    let path = Path::new("input");

    let mut file = match File::open(&path) {
        Err(why) => panic!("couldn't open: {}", why.description()),
        Ok(file) => file,
    };

    let mut input = String::new();
    match file.read_to_string(&mut input) {
        Err(why) => panic!("couldn't read: {}", why.description()),
        Ok(_) => print!("file contains:\n{}", input),
    }

    let instructions: Vec<i32> = input
        .split(',')
        .map(|s| s.trim())
        .map(|s| s.parse().unwrap())
        .collect();

    let result = find_result(&instructions, 19690720);

    println!("result: {}", 100 * result.0 + result.1);
}
