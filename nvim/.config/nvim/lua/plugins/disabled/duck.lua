return {
    "tamton-aquib/duck.nvim",
    config = function()
        -- Table containing animal emojis
        local animalEmojis = {
            "🐶", -- Dog
            "🐱", -- Cat
            "🐭", -- Mouse
            "🐹", -- Hamster
            "🐰", -- Rabbit
            "🦊", -- Fox
            "🐻", -- Bear
            "🐼", -- Panda
            "🐨", -- Koala
            "🐯", -- Tiger
            "🦁", -- Lion
            "🐮", -- Cow
            "🐷", -- Pig
            "🐸", -- Frog
            "🐔", -- Chicken
            "🐧", -- Penguin
            "🐦", -- Bird
            "🐤", -- Baby Chick
            "🦆", -- Duck
            "🦉", -- Owl
            "🦇", -- Bat
            "🐺", -- Wolf
            "🐗", -- Boar
            "🐴", -- Horse
            "🦄", -- Unicorn
            "🐝", -- Honeybee
            "🐛", -- Bug
            "🦋", -- Butterfly
            "🐌", -- Snail
            "🐞", -- Lady Beetle
            "🐜", -- Ant
            "🦗", -- Cricket
            "🕷️", -- Spider
            "🦂", -- Scorpion
            "🦀", -- Crab
            "🐍", -- Snake
            "🦎", -- Lizard
            "🐢", -- Turtle
            "🐠", -- Tropical Fish
            "🐟", -- Fish
            "🐡", -- Blowfish
            "🐬", -- Dolphin
            "🦈", -- Shark
            "🐳", -- Whale
            "🐋", -- Whale
            "🐊", -- Crocodile
            "🐆", -- Leopard
            "🐅", -- Tiger
            "🐃", -- Water Buffalo
            "🐂", -- Ox
            "🐄", -- Cow
            "🦌", -- Deer
            "🐪", -- Camel
            "🐫", -- Two-Hump Camel
            "🦒", -- Giraffe
            "🐘", -- Elephant
            "🦏", -- Rhinoceros
            "🦍", -- Gorilla
            "🐎", -- Horse
            "🐖", -- Pig
            "🐐", -- Goat
            "🐏", -- Ram
            "🐑", -- Ewe
            "🐕", -- Dog
            "🐩", -- Poodle
            "🐈", -- Cat
            "🐓", -- Rooster
            "🦃", -- Turkey
            "🕊️", -- Dove
            "🐇", -- Rabbit
            "🐁", -- Mouse
            "🐀", -- Rat
            "🐿️", -- Chipmunk
            "🦔", -- Hedgehog
            "🐾", -- Paw Prints
            "🐉", -- Dragon
            "🐲", -- Dragon Face
        }

        -- Function to return a random animal emoji
        local function getRandomAnimalEmoji()
            math.randomseed(os.time()) -- Seed random number generator with current time
            local randomIndex = math.random(1, #animalEmojis) -- Generate random index within the range of animal emojis table
            return animalEmojis[randomIndex] -- Return the randomly selected animal emoji
        end

        vim.keymap.set("n", "<leader>dd", function()
            require("duck").hatch(getRandomAnimalEmoji())
        end, {})
        vim.keymap.set("n", "<leader>dk", function()
            require("duck").cook()
        end, {})
        vim.keymap.set("n", "<leader>da", function()
            require("duck").cook_all()
        end, {})

        require("duck").hatch(getRandomAnimalEmoji())
    end,
}
