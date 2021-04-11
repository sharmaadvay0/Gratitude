# Gratitude

## Inspiration
Our team wanted to create something that encourages people to check up on their wellness. People often underestimate their mental and physical shape. You often hear people say "I'm fine" when they really aren't. Sometimes your friends will be in stuck between a rock and a hard place, but you might not realize it fast enough to help them. We brainstormed an app idea that could interact with this problem space which became **Graditude**. Even if people weren't dealing with tough situations such as COVID-19, we still want to encourage them to keep track of their wellness when they're in an upbeat mood. That way people can know at all times how they're feeling and the trends associated with their mental health. We combined elements of a social media platform with some causal analytical UI in order to create a smooth user experience. This idea was meant to encourage constant recording of mental states because it is so quick and easy to do. Wellness is important to keep up and Gratitude is an app for you to track it all.

## What it does
Gratitude allows users to create posts about their daily mental state. With each post, users are given the option to provide a description of their day, a slider to measure what they were feeling, and a selection of categories related to the events that happened. User sentiment is analyzed and can be stored in a way where they can see how often they feel a certain way. These posts are displayed in a feed where anyone can tap on it to see more information about that particular post. Users can also navigate to other users' profiles and become friends through the app. With these functionalities, users can more easily track their friends wellbeing along with their own.

## How we built it
The front end was built using Apple's SwiftUI to create a standard user interface. The back end was made using Python and Flask on Google App Engine. User sentiment was analyzed using Google Cloud Platform's NLP processing, and post information was stored on Google Firestore.

## Challenges we ran into
There were a few challenges that came up over the course of the hackathon. We were using SwiftUI which is a relatively new framework for building iOS app user interfaces. Although it was released in 2014, Apple's other UI development framework UIKit remains the primary way to build user interfaces. Since it was new, there was a small learning curve when building Gratitude. Another challenge was creating the design and user interface for our graphs and analytics. It was difficult to design with a simple way to display meaningful data, but we were able to do it by grabbing inspiration from Spotify and Robinhood's user interfaces. After finalizing a design, we were able to create a similar feature for Gratitude. These are just some of the many challenges we faced during the development process.

## Accomplishments that we're proud of
Gratitude is a great minimum viable product that is ready to use for anyone and anywhere. The app works especially well now due to the ongoing effects of COVID-19 on our mental and physical health. We made Gratitude knowing we can scale up for more users and add many other features.

## What we learned
We learned a lot about new technologies like SwiftUI, Google Cloud Platform, and most of all how important it is to take care of your mental and physical health. This project wouldn't be possible without taking healthy breaks!

## What's next for Gratitude
We have many features planned for Gratitude that are just waiting to be implemented. Features such as notifications, physical health analysis, and more analytics will improve user experience by a lot. Although the app is working locally, we still have the option to potentionally deploy it to the Apple App Store.
