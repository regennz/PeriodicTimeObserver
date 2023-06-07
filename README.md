# Bug Submission: addPeriodicTimeObserver

## Description
This README file provides information about a bug related to the `addPeriodicTimeObserver` method in Apple's framework. This bug affects the periodic time observation functionality, causing unexpected behavior or errors. Please read the following sections for detailed information on how to reproduce the bug, its expected behavior, and any additional notes.

## Bug Details

- Bug Title: Bug in addPeriodicTimeObserver method
- Framework: AVFoundation
- Method: addPeriodicTimeObserver: forInterval: queue: block:

## Steps to Reproduce
To reproduce the bug, follow these steps:

1. Open this project
2. Build and run to see the expected behavior.
3. Uncomment line 79 of CustomVideoPlayerNoVM
4. Build and run again to see the issue

## Expected Behavior
The `addPeriodicTimeObserver` method should register a time observer that invokes a block periodically based on the specified interval and queue. The expected behavior is for the block to be executed at regular intervals as specified.

## Actual Behavior
When I add some code in the code block, the block no longer fires at the specified interval, and fires at a much higher rate.

## Environment
Please provide information about your development environment:

- Device: Simulator and iPhone 14 Pro
- Operating System: ios 16.4
- Xcode Version: 14.3.1

## Contact Information
Please include your contact information below so that Apple engineers can reach out to you for further clarification or updates regarding the bug submission:

- Name: Daniel Too
- Email: dan.too@gmail.com

