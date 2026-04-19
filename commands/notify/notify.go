package notify

import (
	"fmt"
	"os"
)

func Controller() {

	if len(os.Args) < 1 {
		fmt.Println("Usage: fishstick notify <send/set-muted/get-muted>")
		return
	}

	arg := os.Args[1]


	if arg == "send" {
		Send()
	} else if arg == "set-muted" {
		SetMuted()
	} else if arg == "get-muted" {
		GetMuted()
	}
}