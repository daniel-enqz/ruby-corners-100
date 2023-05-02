# Failure as a breach of contract

This repo is a set of excercises to practice exceptions, failures and error handling.
Took inspiration from: [Exceptional Ruby by Avdi Grimn](https://drive.google.com/drive/folders/1pji-ot0DVqdIlnkz6SdCAVk0-EYsGAXU)

---

A method’s contract states “given the following inputs, I promise to return

certain outputs and/or cause certain side-effects”. It is the callers respon-
sibility to ensure that the method’s preconditions—the inputs it depends

on—are met. It is the method’s responsibility to ensure that its postcondi-
tions—those outputs and side-effects—are fulfilled.

---

_"Whatever the reason for the failure, a robust Ruby program needs to have
a coherent plan in place for handling exceptional conditions"_

```ruby
def handle_message(message)
  if message.type == "success"
handle_success(message)
  else
5 handle_failure(message)
  end
end

message.type # => "stats"
10 handle_message(message) # Uh oh!
```
