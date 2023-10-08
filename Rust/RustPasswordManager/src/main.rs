use fltk::{
    app,
    prelude::*,
    window::Window,
    frame::Frame,
    image::PngImage,
    input::{Input, SecretInput},
    button::Button,
    enums::{Color, FrameType},
};
use rand::Rng; // Import the rand crate
use std::cell::RefCell;
use std::rc::{Rc, Weak};
use std::borrow::BorrowMut;


fn main() {
    let app = app::App::default();
    let mut wind = Window::default()
        .with_size(700, 550)
        .center_screen()
        .with_label("Password Manager");
    wind.set_color(Color::Light2);

    // Load the image from the assets directory
    let image = match PngImage::load("E:/RustPasswordManager/RustPasswordManager/src/assets/logo.png") {
        Ok(image) => image,
        Err(err) => {
            eprintln!("Failed to load the image: {}", err);
            return; // Exit the program gracefully
        }
    };

    let image_width = image.width() as i32;
    let image_height = image.height() as i32;

    // Calculate the position to center the image in the window
    let x = (wind.width() - image_width) / 2;
    let y = (wind.height() - image_height) / 2;

    // Create a frame widget to display the loaded image in the center
    let mut frame = Frame::default()
        .with_size(image_width, image_height)
        .with_label("")
        .with_pos(x, y);
    frame.set_image(Some(image));

    // Create a horizontal frame to contain label, input, and button
    let mut horizontal_frame = Frame::default()
        .with_size(800, 50) // Adjust the size to match the window width
        .with_pos(-300, image_height + 190); // Position it below the image with some vertical spacing
    horizontal_frame.set_frame(FrameType::FlatBox);
    horizontal_frame.set_label("");
    horizontal_frame.set_color(Color::Light2);

    // Add a label to the horizontal frame
    let mut label = Frame::default()
        .with_size(100, 30)
        .with_label("Label:");
    label.set_align(fltk::enums::Align::Left);
    horizontal_frame.set_frame(FrameType::FlatBox);
    horizontal_frame.set_label("Website:");

    // Add an input field to the horizontal frame
    let mut input = Input::default()
        .with_size(350, 30)
        .with_pos(160, image_height + 200);

    // Add a button to the horizontal frame
    let mut button = Button::default()
        .with_size(100, 30)
        .with_pos(520, image_height + 200)
        .with_label("Search");



    // Create another horizontal frame to contain label, input, and button
    let mut horizontal_frame2 = Frame::default()
        .with_size(800, 20) // Adjust the size to match the window width
        .with_pos(-300, image_height + 240); // Position it below the image with some vertical spacing
    horizontal_frame2.set_frame(FrameType::FlatBox);
    horizontal_frame2.set_label("");
    horizontal_frame2.set_color(Color::Light2);

    // Add a label to the horizontal frame
    let mut label2 = Frame::default()
        .with_size(100, 30)
        .with_label("Label:");
    label2.set_align(fltk::enums::Align::Left);
    horizontal_frame2.set_frame(FrameType::FlatBox);
    horizontal_frame2.set_label("Username:");

    // Add an input field to the horizontal frame
    let mut input2 = Input::default()
        .with_size(460, 30)
        .with_pos(160, image_height + 240);


    // Create another horizontal frame to contain label, input, and button
    let mut horizontal_frame3 = Frame::default()
        .with_size(800, 20) // Adjust the size to match the window width
        .with_pos(-300, image_height + 280); // Position it below the image with some vertical spacing
    horizontal_frame3.set_frame(FrameType::FlatBox);
    horizontal_frame3.set_label("");
    horizontal_frame3.set_color(Color::Light2);

    // Add a label to the horizontal frame
    let mut label2 = Frame::default()
        .with_size(100, 30)
        .with_label("Label:");
    label2.set_align(fltk::enums::Align::Left);
    horizontal_frame3.set_frame(FrameType::FlatBox);
    horizontal_frame3.set_label("Password:");

    // Add an input field to the horizontal frame
    let mut input3 = SecretInput::default()
        .with_size(250, 30)
        .with_pos(160, image_height + 280);

    let mut input3_normal = Input::default()
        .with_size(250, 30)
        .with_pos(160, image_height + 280);
        

    // Add a button to the horizontal frame
    let mut button3 = Button::default()
        .with_size(100, 30)
        .with_pos(415, image_height + 280)
        .with_label("Generate");

    // Add a button to the horizontal frame
    let mut button3_1 = Button::default()
        .with_size(100, 30)
        .with_pos(520, image_height + 280)
        .with_label("Show");


    // Create another horizontal frame to contain label, input, and button
    let mut horizontal_frame4 = Frame::default()
        .with_size(800, 20) // Adjust the size to match the window width
        .with_pos(-100, image_height + 320); // Position it below the image with some vertical spacing
    horizontal_frame4.set_frame(FrameType::FlatBox);
    horizontal_frame4.set_label("");
    horizontal_frame4.set_color(Color::Light2);

    // Add a button to the horizontal frame
    let mut button4 = Button::default()
        .with_size(460, 30)
        .with_pos(160, image_height + 320)
        .with_label("Add");
    

    // Clone a reference to the input field
    let mut is_secret = true;
    

    let mut input3_clone =input3.clone(); // Clone the input field reference for use in the event handler
    let input3_normal_clone = input3_normal.clone();

    // Create an Rc to hold a reference to the SecretInput
    let input3_rc = Rc::new(RefCell::new(input3.clone()));
    let input3_normal_rc = Rc::new(RefCell::new(input3_normal.clone()));

    input3_normal.hide();

    // Clone a reference to is_secret
    let  is_secret_clone1 = Rc::new(RefCell::new(is_secret.clone()));
    let  is_secret_clone2 = Rc::new(RefCell::new(is_secret.clone()));

    // Event handler for button3_1
    let mut button3_1_clone = button3_1.clone(); // Clone the button reference for updating its label

    button3_1.set_callback(move |_| {
        
        // Get the text from the input field
        let password = input3_clone.value();

        // Toggle is_secret_clone1
        is_secret = !is_secret;
        
        if is_secret {

            button3_1_clone.set_label("Show");
            input3_clone.show();
            input3_normal.hide();
            input3_normal.set_value(&input3_normal.value());
        }
        else {
            button3_1_clone.set_label("Hide");
            input3_clone.hide();
            input3_normal.show();
            input3_normal.set_value(&input3_clone.value());
            
        }
    });


    // Event handler for button3
    button3.set_callback(move |_| {

    if let Ok(mut input3) = input3_rc.try_borrow_mut() {
        
        // Generate a random password of length 10
        let password: String = (0..10)
        .map(|_| {
            rand::thread_rng()
                .sample(rand::distributions::Alphanumeric)
                as char // Convert u8 to char
        })
        .collect(); // Collect characters into a String

        if is_secret {

            // Set the generated password in the input field
            input3.set_value(&password);
        }
        else {
            if let Ok(mut input3_normal) = input3_normal_rc.try_borrow_mut() {
                input3_normal.set_value(&password);
            }
        }
        println!("{}", is_secret);
    }
    });

    wind.end();
    wind.show();

    app.run().unwrap();
}
