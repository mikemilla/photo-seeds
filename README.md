# Photo Seeds 🖼 🌱

An easier way for humans to create and recover wallets

[<img src="https://raw.githubusercontent.com/mikemilla/photo-seeds/master/demo.gif" width="250"/>](https://raw.githubusercontent.com/mikemilla/photo-seeds/master/demo.gif)

&nbsp;

## How do you try out Photo Seeds?

1. Install Flutter: https://docs.flutter.dev/get-started/install
2. Run: `git clone https://github.com/mikemilla/photo-seeds.git`
3. Open the folder you cloned
4. Run: `flutter pub get`
4. Run: `flutter run`

This demo runs on iOS and Android and uses a few common libraries to make it functional. See the `pubspec.yaml` for the libraries used.

&nbsp;

## Why does Photo Seeds exist?

"Seed Phrases" are weird, scary, and impractical for most people. Photo Seeds is an attempt at making self-owned wallets easier to remember and recover.

The purpose of "mnemononic seed phrases" is to create a secure, unique and repeatable "password" that humans can use to recover a wallet. The current conventional user experience of this is not ideal. Most people have no idea what "seed phrases" mean, why they can't pick the words, why there are (usually) 12 words, why they should write them down, and why they should not take a screenshot of them. Another issue is that it's hard to memorize a seed phrase. It's not impossible, but average people won't remember them. If someone needed to recover a wallet, don't have or remember their seeds, and did have their phone with access to iCloud or Google Photos (a decently common scenario), seed phrases not ideal.

If we are going to get 8 billion humans capable of using self-owned crypto wallets, we need to make this experience more humanlike!

"A picture is worth a thousand words" and humans are visual, story driven creatures. Odds are much higher that someone will remember a photo or a number of photos, and the order of those photos before they remember 12 random words. I'm sure you reading this have some images in your photo library that only you would remember and you may have a 12 word seed phrase that you don't remember.

Photo seeds gives people an easier way to remember how to login to a crypto wallet, without requiring people to write anything down.

&nbsp;

---

&nbsp;

## Are Photo Seeds secure?

The image to hash function is probably more secure than a single word, however, that doesn't mean that this is overall more secure than traditional seed phrases, in fact, it probably is less secure. There are other ways someone could try and steal another user's seeds.

Gaining access to someone's photo library via iCloud or Google Photos, downloading all the images, and writing a brute force script would eventually try all the image hash combinations could steal another user's seeds. This isn't ideal, but probably is ok for a decently large number of people. Apple and Google have very robust security measures and Photo Seeds indirectly depend on their security procautions.

If the idea of converting more humanlike things into seed phrases catches on, an open source, publicly trusted library for this type of thing is probably needed. At this point, giving developers access to the user's photo files is a security concern. How do we prevent wallet developers from stealing all the photo files and trying the combinations to steal user's wallets? Maybe we create a token with voting rights to make commits to the library? Someone probably needs to moderate what is safe for developers to use in their apps so people's can trust this type of feature.

&nbsp;

## How can we make idea even better?

&nbsp;

<b>💡 Use bitmaps instead of files</b>

Currently, the image files themselves are hashed. This is ok, but using the bitmaps of the images without the metadata of the files and determining the entropy of the bitmap may be better. The reason I think that approach might be better is because there is a higher chance of that working across Apple's iCloud and Google Photos. Images without all the filemeta data will have a different hash output and the ideal user experience would be cross platform while still being highly secure.

&nbsp;

<b>💡 Create a library that is easy to add to apps</b>

This repo is just a proof of concept of this idea. To make this available for actual usage in wallets, we need to create a library and pub.dev, npm, gradle, swift package manager, or cocoapods package.

The security concerns of this are mentioned above.

&nbsp;

<b>💡 Support other blockchains</b>

This version only supports Bitcoin wallets, but Ethereum, Solana, etc are all possible with this same type of approach, they just needed to be coded up.

&nbsp;

<b>💡 Support other types of media to create seeds</b>

What are other things humans can relate more to than random words? Some example could be quotes, lyrics, video timestamps, tweets, links on the web, hex colors, drawing images and having device side machine learning determine the object or something else!

There are plenty of other things humans are more likely to remember than seed phrases. Finding the right balance of easy to remember, low friction user experience to recovery and security is the challenge.

&nbsp;

## How can you contribute?

Feel free to fork this repo, open a PR, create a library, issues, or message me on Twitter.

Hopefully this idea can start point us in the right direction of making user experience a higher priority in the crypto world!

https://twitter.com/killamikemilla
