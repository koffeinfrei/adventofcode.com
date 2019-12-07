use std::error::Error;
use std::fs::File;
use std::io::prelude::*;
use std::path::Path;

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

    let mut instructions: Vec<i32> = input
        .split(',')
        .map(|s| s.trim())
        .map(|s| s.parse().unwrap())
        .collect();

    // adjust initial values
    instructions[1] = 12;
    instructions[2] = 2;

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

    println!("sequence: {:?}", instructions);
    println!("result: {}", instructions[0]);
}
