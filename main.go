package main

import (
	"fmt"
	"os"
	"github.com/PedroThiagoMaisse/fishstick/commands/test"
	
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: fishstick <command>")
		return
	}

	arg := os.Args[1]

	if arg == "test" {
		test.Test()
	} else {
		fmt.Printf("Unknown command: %s\n", arg)
	}
}