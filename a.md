macro_rules! println

Prints to the standard output, with a newline.

On all platforms, the newline is the LINE FEED character (\n/U+000A) alone
(no additional CARRIAGE RETURN (\r/U+000D)).

This macro uses the same syntax as format, but writes to the standard output instead.
See [std::fmt] for more information.

The println! macro will lock the standard output on each call. If you call
println! within a hot loop, this behavior may be the bottleneck of the loop.
To avoid this, lock stdout with io::stdout().lock:

use std::io::{stdout, Write};

```rust
let mut lock = stdout().lock();
writeln!(lock, "hello world").unwrap();

```

Use println! only for the primary output of your program. Use
[eprintln] instead to print error and progress messages.

# Panics

Panics if writing to [io::stdout] fails.

Writing to non-blocking stdout can cause an error, which will lead
this macro to panic.

# Examples

println!(); // prints just a newline
println!("hello there!");
println!("format {} arguments", "some");
let local_variable = "some";
println!("format {local_variable} arguments");
p

