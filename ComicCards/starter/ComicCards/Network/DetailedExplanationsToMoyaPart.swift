/*
https://www.raywenderlich.com/5121-moya-tutorial-for-ios-getting-started
 
public enum Marvel: enumeration describing the API service:
 
1. Marvel public and private keys;  You store them alongside the definition of your service to make sure the keys are easily accessible as part of your service configuration.
2. A single enumeration case named comics, which represents the only endpoint you’re going to hit in Marvel’s API — GET /v1/public/comics.
 
 Conform to TargetType:
 
 1. Every target (e.g., a service) requires a base URL. Moya will use this to eventually build the correct Endpoint object.
 2. For every case of your target, you need to define the exact path you’ll want to hit, relative to the base URL. Since the comic’s API is at https://gateway.marvel.com/v1/public/comics, the value here is simply /comics.
 3. You need to provide the correct HTTP method for every case of your target. Here, .get is what you want.
 4. sampleData is used to provide a mocked/stubbed version of your API for testing. In your case, you might want to return a fake response with just one or two comics. When creating unit tests, Moya can return this “fake” response to you instead of reaching out to the network. As you won’t be doing unit tests for this tutorial, you return an empty Data object.
 5. task is probably the most important property of the bunch. You’re expected to return a Task enumeration case for every endpoint you want to use. There are many options for tasks you could use, e.g., plain request, data request, parameters request, upload request and many more. This is currently marked as “to do” since you’ll deal with this in the next section.
 6. headers is where you return the appropriate HTTP headers for every endpoint of your target. Since all the Marvel API endpoints return a JSON response, you can safely use a Content-Type: application/json header for all endpoints.
 7. validationType is used to provide your definition of a successful API request. There are many options available and, in your case, you’ll simply use .successCodes which means a request will be deemed successful if its HTTP code is between 200 and 299.
 
 
 Note: Notice that you’re using a switch statement in all of your properties even though you only have a single case (.comics). This is a general best practice, since your target might easily evolve and add more endpoints. Any new endpoint will require its own values for the different target properties.
 
 TASK:
 
 1. You create the required hash, by concatenating your random timestamp, the private key and the public key, then hashing the entire string as MD5. You’re using an md5 helper property found in Helpers/String+MD5.swift.
 2. The authParams dictionary contains the required authorization parameters: apikey, ts and hash, which contain the public key, timestamp and hash, respectively.
 3. .requestParameters task type, which handles HTTP requests with parameters. You provide the task with several parameters indicating that you want up to 50 comics from a given week sorted by latest onsaleDate. You add the authParams you created earlier to the parameters dictionary so that they’re sent along with the rest of the request parameters.
 
 
 state in viewDidLoad() in ComicsViewController
 
 1.  Set the view’s state to .loading.
 2.  Use the provider to perform a request on the .comics endpoint. Notice that this is entirely type-safe, since .comics is an enum case. So, there’s no worry of mis-typing the wrong option; along with the added value of getting auto-completed cases for every endpoint of your target.
 3.  The closure provides a result which can be either .success(Moya.Response) or .failure(Error).
 4. If the request succeeds, you use Moya’s mapJSON method to map the successful response to a JSON object and then print it to the console. If the conversion throws an exception, you change the view’s state to .error.
 5.  If the returned result is a .failure, you set the view’s state to .error as well.
 
 the JSON response’s structure looks something like:
 
                     data ->
                     results ->
                     [ Array of Comics ]
 
 Meaning two levels of nesting (data, results) before getting to the objects themselves. The starter project already includes the proper Decodable object that takes care of decoding this.
 

 replace print with --> self.state = .ready(try response.map(MarvelResponse<Comic>.self).data.results)
 
 Instead of mapping the object to a raw JSON response, you use a mapper that takes the MarvelResponse generic Decodable with a Comic struct. This will take care of parsing the two levels of nesting as well, which lets you access the array of comics by accessing data.results.
 
 You set the view’s state to .ready with its associated value being the array of Comic objects returned from the Decodable mapping.
 
 
 
 In CardViewController.swift - the layoutCard(comic:) method:
 
 Updates the screen with information from the provided Comic struct by:
 
 1.Setting the comic’s title and the comic’s description.
 2. Setting the list of characters for the comic, or, “No characters” if there are no characters.
 3. Setting the “on sale” date of the comic, using a pre-configured DateFormatter.
 4. Loading the comic’s image using Kingfisher — a great third-party library for loading web images.

 
 Two more features to add: uploading your card to Imgur and letting the user delete the card.
 
 Create another Moya target named Imgur that will let you interact with two different endpoints for image handling: one for uploading and one for deleting.
 
 Similar to the Marvel API, you:
 
 1. Store your Imgur Client ID in clientId. Make sure to replace this with the Client ID generated in the previous step (you don’t need the secret).
 2. Define the two endpoints that you’ll be using: upload, used to upload an image, and delete, which takes a hash for a previously uploaded image and deletes it from Imgur. These are represented in the Imgur API as POST /image and DELETE /image/{imageDeleteHash}.
 
 
 Next, conform to TargetType:
 
 1. The base URL for the Imgur API is set to https://api.imgur.com/3.
 2. You return the appropriate endpoint path based on the case. /image for .upload, and /image/{deletehash} for .delete.
 3. The method differs based on the case as well: .post for .upload and .delete for .delete.
 4. Just like before, you return an empty Data struct for sampleData.
 5. The task is where things get interesting. You return a different Task for every endpoint. The .delete case doesn’t require any parameters or content since it’s a simple DELETE request, but the .upload case needs some more work.
 
 To upload a file, you’ll use the .uploadMultipart task type, which takes an array of MultipartFormData structs. You then create an instance of MultipartFormData with the appropriate image data, field name, file name and image mime type. (The Multipurpose Internet Mail Extensions (MIME) type is a standardized way to indicate the nature and format of a document...)
 
 6. Like the Marvel API, the headers property returns a Content-Type: application/json header, and an additional header. The Imgur API uses Header authorization, so you’ll need to provide your Client ID in the header of every request, in the form of Authorization: Client-ID (YOUR CLIENT ID).
 7. The .validationType is the same as before — valid for any status codes between 200 and 299.
 
 Moya related code completed
 
 
 Need to do:
 
 Create a MoyaProvider instance, this time with the Imgur target. You also define uploadResult — an optional UploadResult property you’ll use to store the result of an upload, which you’ll need when deleting an image.
 
 func upload images:
 
 1. You use a helper method called snapCard() to generate a UIImage from the presented card on screen.
 2. Like with the Marvel API, you use your provider to invoke the upload endpoint with an associated value of the card image.
 callbackQueue allows providing a queue on which you’ll receive upload progress updates in the next callback. You provide the main DispatchQueue to ensure progress updates happen on the main thread.
 You define a progress closure, which will be invoked as your image is uploaded to Imgur. This sets the progress bar’s progress and will be invoked on the main DispatchQueue provided in callbackQueue.
 When the request completes, you fade out the upload view and the share button.
 As before, you handle the success and failure options of the result. If successful, you try to map the response to an ImgurResponse and then store the mapped response in the instance property you defined before.
 You’ll use this property later when finishing up the deleteCard() method. After storing the upload result, you trigger the presentShare method which will present a proper share alert with the URL to the uploaded image, and the image itself. A failure will trigger the presentError() method.
 
 
 func delete images:
 
 1. You make sure the uploadResult is available and disable the delete button so the user doesn’t tap it again.
 2. You use the Imgur provider to invoke the delete endpoint with the associated value of the upload result’s deletehash. This hash uniquely identifies the uploaded image.
 3. In case of a successful or failed deletion, you show an appropriate message.
 */

