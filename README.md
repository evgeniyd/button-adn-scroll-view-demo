# About
[Demo] Handle tap gesture on `UIButton` and forward pan gesture to `UIScrollView`

# Problem 

I have a `UIControl` (button) and `UIScrollView` (collection view) added to the same superview. The button is laid out in a way that part of it overlaps the collection view frame. When pan gestures starts on the button, the collection view has to scroll. However, by default button handles all the events originated in it's frame.

# What I've tried

If the button is added on collection view - I have no problems solving the issue with additional pan gesture added to button, and then implementing `-shouldRecognizeSimultaneouslyWith` . However, scroll view clips its content, and half of the button frame is clipped (because `UIScrollView` by default does that -- and I cannot change it because of the potential side effects).
When I add button to common superview, I tried to implement `hitTest`, but I do not know how to correctly handle the return of the button or collection view.


<img src="https://github.com/user-attachments/assets/237516d7-8a8c-49b6-8421-401fa94f1952" width="400">

Shows 2 solutions, each has its own pros and cons:

## `ContainerViewHit` Solution

**Pros:**
1. Passes pan gestures that originates in button to collection view

**Cons:**
1. Button target-action does not work

## `ContainerViewGesture` Solution

**Pros:**
1. Passes pan gestures that originates in button to Collection View
2. Button target-action works

**Cons:**
1. Button is cropped 
