package notify

import (
	"fmt"
	"os"
)

func Controller() {

	if len(os.Args) < 2 {
		fmt.Println("Usage: fishstick notify <send/set-muted/get-muted>")
		return
	}

	arg := os.Args[1]

	switch arg {
		case "send":
			Send()
		case "set-muted":
			SetMuted()
		case "get-muted":
			GetMuted()
		default:
			fmt.Println("No valid mode find")
	}
}