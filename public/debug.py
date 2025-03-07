import hashlib

def get_password():
    parts = [
        chr(0x42) + chr(0x31),
        "".join([chr(x) for x in [0x7A, 0x54]]),
        "3ch",  
        chr(0x4C) + "4bs!"
    ]
    
    password = "".join(parts)
    return password

def check_password(user_input):
    correct_hash = "d1b1a1b1e1c1a1b1e1c1a1b1e1c1a1b1"  # Update this with the correct hash
    return hashlib.md5(user_input.encode()).hexdigest() == correct_hash

if __name__ == "__main__":
    print("Enter the correct password to access:")
    user_input = input("> ")

    if check_password(user_input):
        print("Access Granted! The password is correct.")
    else:
        print("Access Denied! Try again.")
