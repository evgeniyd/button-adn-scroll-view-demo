# About
[Demo] Handle tap gesture on `UIButton` and forward pan gesture to `UIScrollView`

# Description

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
