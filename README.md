#  TestURLSesionCancel

![](TestURLSesionCancel.png)

```swift
let nse = urlError as NSError
if (nse.code == NSURLErrorCancelled) {
	print("the URLSessionTask was cancelled")
}
```
