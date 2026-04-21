package main

import (
	"fmt"
	"os"

	"github.com/PedroThiagoMaisse/fishstick/cmd/notify"
	"github.com/PedroThiagoMaisse/fishstick/cmd/test"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: fishstick <command>")
		return
	}

	arg := os.Args[1]

	// Shift arguments so sub-commands can parse their own flags if needed
	os.Args = append([]string{os.Args[0]}, os.Args[2:]...)

	switch arg {
	case "test":
		test.Test()
	case "notify":
		notify.Controller()
	default:
		fmt.Printf("Unknown command: %s\n", arg)
		os.Exit(1)
	}
}