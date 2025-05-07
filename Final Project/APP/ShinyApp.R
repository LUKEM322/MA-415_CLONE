library(shiny)
library(shinydashboard)
library(leaflet)
library(DT)
library(plotly)
library(ggplot2)
library(dplyr)
library(shinythemes)

# UI
ui <- navbarPage(
  title = "Lord Howe Island",
  theme = shinytheme("flatly"),
  
  # 1. Location Tab with Map
  tabPanel(
    "Location",
    fluidRow(
      column(
        width = 8,
        h2("Location of Lord Howe Island"),
        p("Lord Howe Island is a UNESCO World Heritage-listed paradise located in the Tasman Sea between Australia and New Zealand. It's approximately 600km east of the Australian mainland."),
        leafletOutput("map", height = 500),
        br(),
        h3("Getting There"),
        p("The island is accessible via regular flights from Sydney and Brisbane. The flight duration from Sydney is approximately 2 hours."),
        p("Other than the daily flights from sydney some choose to brave the open seas, but this is only possible by private vessel")
      ),
      column(
        width = 4,
        h3("Quick Facts"),
        tags$ul(
          tags$li("Location: Tasman Sea, 600km east of Australia"),
          tags$li("Area: 14.55 km²"),
          tags$li("Length: 10 km"),
          tags$li("Width: 2 km at its widest point"),
          tags$li("Highest Point: Mount Gower (875m)"),
          tags$li("Time Zone: UTC+10:30")
        ),
        h3("Island Highlights"),
        tags$div(
          class = "well",
          tags$ul(
            tags$li("UNESCO World Heritage Site since 1982"),
            tags$li("Only 400 visitors allowed on the island at any time"),
            tags$li("Home to many endemic species"),
            tags$li("Surrounded by the world's southernmost coral reef")
          )
        ),
        hr(),
        div(
          style = "text-align: center;",
          h4("Island Overview"),
          tags$img(src = "https://lordhoweisland.info/wp-content/uploads/2020/11/Elizabeth-Allnutt2.jpg", 
                   width = "100%", style = "border-radius: 8px; margin-top: 10px;")
        )
      )
    )
  ),
  
  # 2. Places to Stay Tab
  tabPanel(
    "Places to Stay",
    fluidRow(
      column(
        width = 12,
        h2("Accommodation on Lord Howe Island"),
        p("From luxurious resorts to cozy lodges, Lord Howe Island offers a range of accommodation options."),
        p("Find where to stay on the island - from guesthouses, family-friendly self-contained apartments, to exclusive luxury lodges. There are just 400 visitor beds on Lord Howe, which is part of what makes it so special. Lord Howe Island's accommodation is limited, so it is important to book flights and accommodation at the same time.")
      )
    ),
    hr(),
    fluidRow(
      column(
        width = 4,
        div(
          class = "panel panel-primary",
          div(class = "panel-heading", h3("Luxury Resorts")),
          div(
            class = "panel-body",
            tags$img(src = "https://lordhoweisland.info/wp-content/uploads/2021/01/Arajilla-Retreat.jpg", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;")
            ,
            h4("Arajilla Retreat"),
            p("Arajilla Retreat is Lord Howe Island’s premier retreat nestled under a canopy of Kentia Palms and Banyan Trees. Arajilla is found at the island’s sheltered northern end just moments away from Old Settlement Beach."),
            p("At Arajilla guests have a rare chance to be pampered, walk deserted beaches, take a specialist yoga class, swim through picturesque lagoons, go snorkelling, diving or fishing and experience the island at leisure. Guests at Arajilla revel in the beauty of Lord Howe Island."),
            tags$img(src = "https://lordhoweisland.info/wp-content/uploads/2021/01/2.-Capella-Restaurant.png", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;")
            ,
            h4("Capella Lodge"),
            
            p("Inspired by the carefree spirit of the Australian beach house, Capella is celebrated as Lord Howe Island’s premium luxury retreat and offers the ultimate island castaway experience."),
            p("Combining contemporary design with glorious natural surroundings, Capella’s relaxed aesthetic lets the true stars shine: views of the ocean and Mounts Gower and Lidgbird.")
          )
        )
      ),
      column(
        width = 4,
        div(
          class = "panel panel-primary",
          div(class = "panel-heading", h3("Apartment-Style")),
          div(
            class = "panel-body",
            tags$img(src = "https://lordhoweisland.info/wp-content/uploads/2020/11/051A7356-5.jpg", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            h4("Somerset Apartments"),
            p("Somerset is a centrally located, but secluded get away. It has easy access to bike and walking paths and is right near Neds beach which offer hand feeding the fish, snorkling, and excellent swimming"),
            p("Perfectly situated between Ned’s beach and the Lagoon, allowing easy walking and biking to nearby shops, restaurants and tour operators. Self-catering units include kitchen facilities, beach towels, backpacks and much more. BBQ facilities onsite."),
            tags$img(src = "https://lordhoweisland.info/wp-content/uploads/2020/11/unnamed.jpg", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            h4("Leanda-lei Apartments"),
            p("Leanda-Lei Apartments is centrally located on the lower end of Middle Beach Road, opposite Joy’s Shop. Only 300m to Lagoon Beach, Visitor Information Centre, Museum and Cafe. Within easy walking distance to most restaurants.")
          )
        )
      ),
      column(
        width = 4,
        div(
          class = "panel panel-primary",
          div(class = "panel-heading", h3("Cabin Style")),
          div(
            class = "panel-body",
            tags$img(src = "https://lordhoweisland.info/wp-content/uploads/2020/11/DSC8041.jpg", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            h4("Lagoon Landing"),
            p("two one bed room beach houses perfect for sharing a holiday with friends. Located opposite the Lagoon Beach and with easy access to walking na dbiking paths"),
            tags$img(src = "https://lordhoweisland.info/wp-content/uploads/2025/02/Copy-of-Chelsea-Scott-Photo-Lord-Howe-Island-The-Cabin-293-e1742518730412.jpg", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            h4("The Cabin"),
            p("Family-owned and thoughtfully designed, The Cabin is a secluded off-grid retreat set on a small hobby farm within Lord Howe Island’s untouched bushland. Nestled on a private five-acre property, this eco-conscious escape offers a rare opportunity to disconnect and unwind while enjoying modern comforts."),
            p("Designed for relaxation and adventure, The Cabin invites guests to unplug from everyday life. Enjoy an outdoor nature shower, explore the island’s scenic walking trails, or spend a quiet evening by the firepit under the stars.")
          )
        )
      )
    )
  ),
  
  # 3. Attractions Tab
  tabPanel(
    "Attractions",
    tabsetPanel(
      tabPanel(
        "Beaches",
        fluidRow(
          column(
            width = 8,
            h2("Beautiful Beaches"),
            p("Lord Howe Island is home to some of the most pristine beaches in the world."),
            hr(),
            fluidRow(
              column(
                width = 6,
                h3("Ned's Beach"),
                tags$img(src = "https://lordhoweisland.info/wp-content/uploads/2021/03/MG_0304-1600.png", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;")
              ),
              column(
                width = 6,
                h3("Lagoon Beach"),
                tags$img(src = "https://ychef.files.bbci.co.uk/1280x720/p084ntjk.jpg", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;")
              )
            ),
            fluidRow(
              column(
                width = 6,
                h3("Blinky Beach"),
                tags$img(src = "https://lordhoweisland.info/wp-content/uploads/2021/03/IMG_0447.png", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;")
              ),
              column(
                width = 6,
                h3("Old Settlement Beach"),
                tags$img(src = " https://lordhoweisland-australia.com/wp-content/uploads/2022/03/Old-Settlement.jpg", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;")
              )
            )
          ),
          column(
            width = 4,
            h3("Beach Activities"),
            tags$ul(
              tags$li("Snorkeling"),
              tags$li("Swimming"),
              tags$li("Surfing"),
              tags$li("Kayaking"),
              tags$li("Bird watching"),
              tags$li("Fish feeding")
            ),
            hr(),
            h3("Beach Guide"),
          tags$img(src = "https://i.pinimg.com/474x/af/22/c5/af22c5def67df69a39e11c541c4d1d83.jpg", 
                   width = "100%", style = "border-radius: 8px; margin-top: 10px;")
        )
        )
      ),
      tabPanel(
        "Museum",
        fluidRow(
          column(
            width = 8,
            h2("Lord Howe Island Museum"),
            tags$img(src = "https://mgnsw.org.au/wp-content/uploads/2018/11/Museum-Lord-Howe-Island-Photo-credit-Glenn-Shipley-SMALL.jpg", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            p("While Lord Howe Island is arguably the most beautiful island in the Pacific, it is also one of the most pristine natural environments, with a wealth of man-made history stretching back one and a half centuries. The Lord Howe Island museum is a treasure chest of natural history, fantastic collections, excellent learning resources, changing displays, inspiring information, great gifts and lots of interactive ways to enjoy learning more about this truly unique place on our plane"),
            h3("Opening Hours"),
            p("Monday - Friday
9:00 am to 3:00 pm
Opening hours are from September to May and from June to August opening hours are reduced

Sunday, Saturday
10:00 am to 2:00 pm")
          ),
          column(
            width = 4,
            h3("Museum Highlights"),
            tags$ul(
              tags$li("Historical artifacts"),
              tags$li("Natural history collection"),
              tags$li("Interactive displays"),
              tags$li("Local art exhibits"),
              tags$li("Island research archives")
            ),
            hr(),
            h3("Address"),
            p("Lagoon Rd & Middle Beach Rd, Lord Howe Island NSW 2898, Australia"),
            hr(),
            h3("Museum Shop"),
            p("The retail shop sells a range of quality books and maps about Lord Howe Island's history, flora and fauna as well as selling photographs, postcards, local crafts and clothing items.")
          )
        )
      ),
      tabPanel(
        "Lookout Points",
        fluidRow(
          column(
            width = 12,
            h2("Scenic Lookout Points"),
            p("Lord Howe Island offers numerous breathtaking vantage points to take in the island's natural beauty.")
          )
        ),
        hr(),
        fluidRow(
          column(
            width = 4,
            h3("Mount Gower"),
            tags$img(src = "https://lordhoweisland.info/wp-content/uploads/2021/03/Mt-Gower-track-IH-1.png", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            h4("Difficulty: Hard"),
            p("Height: 875m")
          ),
          column(
            width = 4,
            h3("Malabar Hill"),
            tags$img(src = "https://www.natureloverswalks.com/wp-content/uploads/2019/02/IMG_7172.jpg", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            h4("Difficulty: Moderate"),
            p("Height: 209m")
          ),
          column(
            width = 4,
            h3("Transit Hill"),
            tags$img(src = "https://assets.atdw-online.com.au/images/b37ee3fa77c6e6d5550a7de67199d46b.jpeg?rect=134%2C0%2C2067%2C1550&w=2048&h=1536&rot=360&q=eyJ0eXBlIjoibGlzdGluZyIsImxpc3RpbmdJZCI6IjU2YjI0OTYxYjA0MjM4NjI0NWQ1MWFhYyIsImRpc3RyaWJ1dG9ySWQiOiI1NmIxZWI5MzQ0ZmVjYTNkZjJlMzIwYzgiLCJhcGlrZXlJZCI6IjU2YjFlZTU5MGNmMjEzYWQyMGRjNTgxOSJ9", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            h4("Difficulty: Easy"),
            p("Height: 121m")
          )
        ),
        hr(),
        fluidRow(
          column(
            width = 4,
            h3("Kim's Lookout"),
            tags$img(src = "https://images.locationscout.net/2022/11/between-the-trees-kims-lookout-lord-howe-island-nsw-australia-anxy.webp?h=1400&q=80", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            h4("Difficulty: Moderate"),
            p("Height: 155m")
          ),
          column(
            width = 4,
            h3("Goat House Cave"),
            tags$img(src = "https://pinetrees.com.au/wp-content/uploads/2019/10/Lord-Howe-Island-330-1200x800.jpg", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            h4("Difficulty: Moderate-Hard"),
            p("Height: 400m")
          ),
          column(
            width = 4,
            h3("Intermediate Hill"),
            tags$img(src = "https://lordhoweisland.info/wp-content/uploads/2020/11/Intermediate-Hill-IH-1.jpg", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            h4("Difficulty: Easy"),
            p("Height: 250m")
          )
        )
      )
    )
  ),
  
  # 4. Wildlife Tab
  tabPanel(
    "Wildlife",
    tabsetPanel(
      tabPanel(
        "Birds",
        fluidRow(
          column(
            width = 8,
            h2("Bird Life on Lord Howe Island"),
            p("Lord Howe Island is a bird watcher's paradise with numerous endemic and migratory species."),
            hr(),
            fluidRow(
              column(
                width = 6,
                h3("Lord Howe Woodhen"),
                tags$img(src = "https://cdn.download.ams.birds.cornell.edu/api/v2/asset/622103316/900", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
                p("The Lord Howe Woodhen is a flightless bird of the rail family. It is endemic to Lord Howe Island off the Australian coast. It is currently classified as endangered by the IUCN.")
              ),
              column(
                width = 6,
                h3("Providence Petrel"),
                tags$img(src = "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRaQxkzQurUgopqW4mEaPZ9QWP8A_1v9xMi9-t51pbyt0d8qeheP_rh2YirqXLpOsjPy8tusEjH5VeOyfaznLSWLg", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
                p("The providence petrel is a large and heavy build gadfly petrel that nests in two locations in the Tasman Sea: Lord Howe Island and Philip Island. The scientific name of this species was given in honour of the Swedish botanist Daniel Solander, with Solander's petrel being an alternative common name.")
              )
            ),
            fluidRow(
              column(
                width = 6,
                h3("Masked Boobies"),
                tags$img(src = "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/304382921/320", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
                p("The masked booby, also called the masked gannet or the blue-faced booby, is a large seabird of the booby and gannet family, Sulidae. First described by the French naturalist René-Primevère Lesson in 1831, the masked booby is one of six species of booby in the genus Sula.")
              ),
              column(
                width = 6,
                h3("Sooty Terns"),
                tags$img(src = "https://storage.googleapis.com/oceanwide_web/media-dynamic/cache/widen_1600/media/default/0001/07/5a33252299cae3a986338090e688b70cb8597190.jpeg", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
                p("The sooty tern is a tern in the family Laridae. It is a seabird of the tropical oceans, and remarkably, has evolved the ability to fly for years at a time, skimming the sea surface for food, and returning to land only to breed, on islands throughout the equatorial zone.")
              )
            )
          ),
          column(
            width = 4,
            h3("Bird Watching Spots"),
            tags$ul(
              tags$li("Malabar Cliffs"),
              tags$li("Mount Eliza"),
              tags$li("North Bay"),
              tags$li("Transit Hill"),
              tags$li("Mutton Bird Point")
            ),
            hr(),
            h3("Endemic Species"),
            p("Lord Howe Golden Whistler"),
            p("Lord Howe Island White-eye"),
            p("Lord Howe Woodhen")
          )
        )
      ),
      tabPanel(
        "Coral Reefs",
        fluidRow(
          column(
            width = 8,
            h2("Coral Reefs"),
            p("Lord Howe Island is surrounded by the world's southernmost coral reef system."),
            hr(),
            fluidRow(
              column(
                width = 6,
                h3("Lord Howe Butterflyfish"),
                tags$img(src = "data:image/webp;base64,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", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
                p("The Lord Howe Island butterflyfish is a butterflyfish of the family Chaetodontidae, found along the east coast of Australia, around Lord Howe Island, and down the east coast of Northland in New Zealand, at depths of between 10 and 150 m. They are up to 20 cm long with black and yellow/white vertical stripes.")
              ),
              column(
                width = 6,
                h3("Doubleheader Wrasse"),
                tags$img(src = "data:image/webp;base64,UklGRvgPAABXRUJQVlA4IOwPAAAwTwCdASriAJsAPqlKn0smJCKlKvMreMAVCWUDvZz2aG8vXeD6L18/ov3PgIBNbc3abwCHv7m9PI+zWV08X4K/3L/0GzQN4TumoOBqLdHZw7Mu1DNaaFjw0s0G0IuhI2tfwh90eSMgMJekXYn/DDMMZXrs8DvN4bXRGoujirez17Nh88GZKzxnGjvgyORn7tnI9j+OPVsuB+kTZnAGIBZSMIe2la+euaQrsqxjpNEeUQhZkE8inf8Lxbe1sNekXW3jYhPFCHrpZ2QjCbSTlFvh9ZejCThyp8oFEdi32xX5XpYmu4PLRm8L6/8NBg8kKSfZPWc52Cu6e8vpEJ+BZ1LOdvrFT+ZxAT47O9881T478llw8odpfYFvb8sutW+Cu1VYz+x9I2Fi8OigKspc9D8ToF5rPgg0m1N63MUptNTlJJAioGKNuw2kxgZyvlHGA3xhtX++2CjZJ63Tkm0Hra7plPqtJ7fTQYvjoiiJbMMNimgWm1uBtUsVGNnUz7vyj2dFrhxWpqB8j+hteHBjuCqSUDQlTAHxjmpAQkSCLREBskmhuNfItZ3yOu3080C3MHYaWUjgvtaq2pNH/qcdAYph5W5VRc/xzUti3YUy8EhqkSg1q4lJ05ZrW9oHRYezf4AxdsLOXr+/IoyqpMrW5JeMdm4VBL4RDzoQ6NIhZdoi9EI3GGWGQTlx3blucjXFSsLKtpLxsRhkpkMuLVVF9EQwbFzhNHH7XdKQeq4rY+2RpL5g3SNaKfHkA/JHzLNg3cjaKih7+NvLp1d/muG6jUuJ94J+KzHuVBs+WxS/ngFxh8hFzL24s9ksWDWy64gcTm8fGNNGW5o8miGlbU2KKDnssAAA/vnSywX+sRdPaGmvhBXl3QBbHiCR3uNANpSIz8wdHSgh1QmSXe8i9Oq4Shjyp6OI+QsJar6UsYWvoX56SrQ988Za1ALy+qxi+B1YFMpONt09VuZez7v3qwR2iAHRfCuH5mXvYhk06DjUDEI3HmYDFguj0RMRuA45Kf1NBBKWTpQvkUpBTxU7DXrfoaCGBfEByYMoEMSdah4k2ZNjNzwIf4mgVkYYUIimvYpx8+ITpTxmYZF2qHVX6SYdC+/lEmDk6teH+N3c+64/4MzMd1CBkyJI5sd9ZjI1TCNdgMmuLvPSJiD1WW+amUIwTe9m5buTFvctboC34K//p71ZLA2vomF6I+TEZNxBO5DI+1lhqjds4zY9FhL/zuFWf+fkZhyMkD7AXT3G7ox9Mmsav9x+YF+8WKxggrKFKdqE8jG+sQZn1Hi6a3yJqFScyo5ScDFr1qsmQWDv9YtmtPuyYjWQ3D0vNJETwVrzKWf8B4DZhSeIvbkHn1gxigjvJXMI4q87ssw/rTnootHUTnI+8LLtBcfeR0t9IshdkKa+RElQbopnmXb/jcykZ54j2XdPRYi6U0kOwfYlfSsm81tslU7AwrF3RLSueKQCv74sRaQmHJ5NTq99+B88OTkVtCNnjFpnyeUXG3jOBByN5hHnDoGShfcLoLTvc1bbvufV48+yg5O7hQ6dGfAcFRvT+VA7ylqo4SyFa/6h5oKC6Xr0rskJCh/y7gFzAx2cRdaNWaBDOx0ac84T3IvEFgjKDnAzrMItU+PbWhRSqU0hTAgdr9oz6b5+KQOxEiAAI0WEan/eYG8SMkv6zRBwTXAwTjQ4J6rRfkbtmmazjPDXd8fgogGEa7nga0hg8Ag8nketj6pS7uJwPFxAvuSyiDROjLW7nLv9eGYj2HLUAyR8gcxG38bI1gNvtHfttwnWk/ZIr34P2SnhRaLf+Qs1oPDZ+Bfr0t6Du+NZm63kqm+o39UcYfhPaD3pXjpJ8RBkzdr870jzeuYkvr+Ah3BAfEhdqQY9A6kBdkJugkoib4yZHrAlYG374cHfsgFu5fKUGOStdRcXhTNPXnOVnftfeGbmFhYRA0RajeCHowrhKfoCtK4RlX4O7m9RS4T2VXatg9CtYNI+EGesE+EVI1jOp8BxrlFr1x+ES9wlG5lsTCqZleP/dQJiuORO6U72r7713NDm57jp0Xs1XKdDYTMNQ636WVxHQXh30H64QuVnInDh6V0RJV3FVZM87uPYeObeihrdS0MSD1u3lZtqki4p0t4EqUK5mOKXxNa4doV2woZ4PNVNOm6PIH4Vz5RVgP3y63QS8ngRLhYv7PnLLt0AmSXuEGyYx3gKKH+T/SMPHW38s4iTDctzqry0FSje2LFi0mROTvybUoIZ1Ouuwp++oRvrXjyHl6UG03Ae68PAZghNReChnlY2Hetg6ckbwMEMs8z35svwQa09q0tEB6drbnkdy0j5pDbRdkBL44x6+CHJoFhRnFekfT9wmSkU8a9QXrYNdkNf23bZ0iwNwbMIEDQ78qtg0IRuYxQRDkPQtvxMhBKL1DNWkaOSAZspqY0b97BBzfoWrFuresREDvpfiG5MraWn/7L6/dq7VnoV/sgSpzEDwAhfvVlDxHkeDjxqxysGXGdt3p450F3JFw/fcNSxvGDlDLV4656KNoEOuSg13nlfPUyZsRpWy78nTCpymPCCccTIxI2la2Rm5Q9GownAr1qkKbhqTDnoE7cGesPkTtSoek1nU7jMy5MrAAJWUiS0ik7OBWJ7SbOOWIh36ANMWOP31EIfnwxGtiZ94zkqwSvPFiwZf6dalFYDgxVb/oYXaLdhYKnuWMne6SI3uSUWoN2F+Eh51GwMhZJL5knlVJN/z8LHiHpTUiLGe4SUbL3sNWoenwcflPqXm8wZM7vi6ZTMEb5bq0gvANgVsbkx+z0Bf73FiG7bE9bjG1e5qzlqquRhnAZi4jep4HyKq4/Vlmlh4NxADpYtx12q2F+PaBZJJ2euQKfldES572IQIwffaC6STBcO301OCWai7TKwypJAkGBLDgLIQnQJpH1WZm9yHAkUUXQU5WgCOKJ/HTC49BpxYfOmdIqUscpaT421uA9cXAfK4Rzd2f4uKX723X2uxyHq2jZDWK86EaaL1+LUwxkvSbWggVS/qpvzgXSIKrzaRez4QR6ULst2ob18Li26wrj/E0b8yccJ02x4z2aIrxfVw6k63y7gv0fXxzZfI0Lploje9bw+TmnaDPmnPkciZS49uI7pcg8UDel5FVp5Qb1DKtu4deo4hAeu4xmCcQYWW4JJTmx8+1vSACWTvRXuKugxemmTwQSQv35kUyzVkjT7Hj2xCerUc1snH9FqTKXfMn+vz7W4/5xWN8h7vyx9NdZXPSFBkRgq2xY+yL4kaPOZmgsMJOgCMAqaZwAOs+gBblougd2HDE3lDQsmWntZOXoDsus5Y/ax6xH5WC2cjTu32HelefZCiUF+AUjp0I0vvYfZ8I/hm44FgtR+uPnkKnQy7V4K446BxFQs4UqRwUl6XnnkYyw0EHLSJ2B03l0bkqzqON471JNK+DGB3XO0vXJbKXW2zSUZOhCPZDchh8aNN8UA1VxC4vN8TpIf1qJ0vWiyajAzAGuZOi6cidkuKad2gj3GEN5wO6mhsJgB5OAB1k6FcP9X6wNCcf8TJNdNEW+EVIeNb4lMAEfzyk2xWUpvNAmQoECmx4Z9tdiUJ853FOO9gl6bFm0riO+1LL2c5Sbgc1EJrM1Qrv7HuDa0ucW0gdb3n4Yk71qD1b36DwqX5VUErel9UDigKkq+ttaZJvX3Fj5wAiaEKRBt5U7b/NSM+3sNd+n/O4kjPtqyAuXeRnRntLqF3toU2yHCyjKMbuXSJ/BPCDwdVG/4kmwqd6amWnwq7qpzwcIoEc2+v7CL5u0s3uSwXgyBxKKwNAoJxBmksD48vFTSd1Rt5cfWz/2r3D+XksWbtYjnqM6mBUQ1HCbjrrtAISkndalkpxOSSpEW7fkbTlyiC1MXVs697NBy9Y9ISzKlPLka5zj+s5/hS1xu4XaNKo8/wnAolXnpaiS19Hu4RWOCNBg6YRg8Tke7KJLMyPwUGQ0OHVBhkOnFMEt/RftAyWC3ZL/MEexRsx9wb0Lwotn7ZoljaQ4uOpre4Ai6RY+NdauKcgmJKaNG9FJOsaQaiYvC4cb8AraThL4oG4XMk6Ttj9CS3KbewqldmhTEWkT8wrwwG5ojnV6/229oGXDXUwF07876fKFZKq5UiDnppIlxjw6dP3qco0GHnyRXx4W7xz6+Bv5ULqjr+nhoSlINzg/p+5Dll4+4GZpoLlOaWZO9/3G7BK5wYiHTxMTzD84HjyNtcd+FJZ6iop8Jrsp2vvmDRD+mM0qeImLzTFXYFEJkfbuy1pzVkOCTqqhXkbZPV5yR3J0tRmktQdsBUOakqxl8RjSbYpYet5EOPnisj+M3mZYiOjudHGBM1uvMEI7oHH7oExG6gD1ul6FYn3G8pVIRnLa6xNQIn2SthVm5TS8TAYBsb/oqALSIVEXV2uKs4f4U+2nsWuIznGRbKxtPSEyoyPsatY4Al1Oh2YtNSGIj21rKoq6FieUWA52aBUFCUd1Sioq+e+Zkvf0v4a9u827QonVckihnjNy8oVECijEposLbYQ17i3r0J7UGYBfPDyqRwch5D6CDHLD9iq/UrV5jmDMHy2libzDPRtS98vo2FOqILxg9Iw6Zg4ju/M96EW4yg73Q1iM9aCZMCwW+cgMkX2JB7441gZZlpvv+n7NnMqXR4lUNvXYMkIxT3sSWwKHcOry8Ikpf3jxmQVG1NwMv+oytKuoov70XSy51jwkpHcinM9zquy8Gh1q2xTBXNqPW1DunD5GeRl/KVObsHcWkeQPTvwzSlOZR/E99sVzJBzHrJ4Q8Du3LGjQfe1fqyX4ulU1gv1TH6xNz2PxHO8uxuIZlnsqZ8jmW3kpaFcapJ/3GwdcHKElGcQzSDUS7xC1qmE27+f+McInGvkv5THqSYRmdYI/p4d0k5pXfhrGuMlGX0qTVgu0cw6CsozGddFIP5AJGDsZAMMfZPEFDZgGmJVhT3AGnrlxo/iTpLLX5e511+en6WA6Iq4IIV7LzhDYhC7bNMOA0kVbtMFgbTQV8tHKRwRMr0bcl27bXjaDoVBQCNM4nnw+1hnwnCQBaj40xbE6pWFl4MLQ8+dQI24HgvjLtR+E+T14M4Pfnsm7NmckcCv6dHkLlyqZV0vzvpdpwzSrFbNseJSBcqYmVFM1ToEIvdehtL0MWFfGmgH8ojVsO4frlCKHR7AQl75Z1NgWF0BvOHcPCtBQ2GRyncHan6Xp6z88iFV0/oaeGjbN5uixZmIyYJlwREd3/hAekhWznsdx4Fc2irIg7fi+tKoaLEYhjaRTrMmqyQYHjoscJMM2Yufwnqye2I0LqM+q79jYB8X1MIxFZpJOzo7ZXaKMrdQbYOAJDg9Vl8dfIdoXMjD6MtqT0bXSVAfUOAMMQ2ixh/SCVUJ5x2+z07Hqm7Bg+9Myb1WGT0fUk4IIhKSGbG8jJhlxcx2qrezLcYmIcAAAAAA==", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
                p("The Doubleheader Wrasse, scientifically known as Coris bulbifrons, is a large fish species endemic to the waters around Lord Howe Island, Elizabeth Reef, and Middleton Reef. It's characterized by a prominent bump on its head, a blue-grey color, and its ability to crush the shells of its prey like crabs and urchins. ")
              )
            ),
            fluidRow(
              column(
                width = 6,
                h3("Pocillopora damicornis"),
                tags$img(src = "data:image/webp;base64,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",
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
                p("Pocillopora damicornis, commonly known as the cauliflower coral or lace coral, is a species of stony coral in the family Pocilloporidae. It is native to tropical and subtropical parts of the Indian and Pacific Oceans.")
              ),
              column(
                width = 6,
                h3("Harlequin sweetlips"),
                tags$img(src = "https://media.australian.museum/media/dd/images/Spotted_Sweetlips_Plectorhinchus_chaetodonoid.width-1600.bd052fe.jpg", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
                p("harlequin sweetlips, clown sweetlips, spotted sweetlips or many-spotted sweetlips, is a species of marine ray-finned fish, a sweetlips belonging to the subfamily Plectorhinchinae, one of two subfamilies in the family Haemulidae, the grunts. It is native to the Indo-Pacific region.")
              )
            )
          ),
          column(
            width = 4,
            h3("Snorkeling Spots"),
            tags$ul(
              tags$li("Ned's Beach"),
              tags$li("Old Settlement Beach"),
              tags$li("North Bay"),
              tags$li("Erscott's Hole"),
              tags$li("Comet's Hole")
            ),
            hr(),
            h3("Reef Conservation"),
            tags$img(src = "https://www.coralreef.noaa.gov/media/images_infographics/Coral-Reefs-Restoration_large.png", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            p("When Visiting Coral Reefs. Practice safe and responsible diving and snorkeling. Avoid touching reefs or anchoring your boat on the reef. Contact with the reef will damage the delicate coral animals, and anchoring on the reef can kill corals, so look for sandy bottom or use moorings, if available.")
          )
        )
      ),
      tabPanel(
        "Whale Watching",
        fluidRow(
          column(
            width = 8,
            h2("Whale Watching"),
            p("Lord Howe Island offers excellent opportunities for whale watching during migration seasons."),
            hr(),
            fluidRow(
              column(
                width = 6,
                h3("Humpback Whales"),
                tags$img(src = "https://www.fisheries.noaa.gov/s3//dam-migration/2160x1440_humpbackwhale_noaa.jpg", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
                p("Humpback whales frequently visit the waters around Lord Howe Island, especially during their migration between the Antarctic and the warmer waters of the Coral Sea. The Lord Howe Island Marine Park is a known hotspot for humpback whales, with sightings increasing as their populations recover from whaling. ")
              ),
              column(
                width = 6,
                h3("Southern Right Whales"),
                tags$img(src = "https://whalewatchwa.mymedia.delivery/2400x1600/p/o/wp-content/uploads/2024/01/Whale-Watch-Western-Australia-12.jpg", 
                         width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
                p("Southern right whales are known to migrate through the waters near Lord Howe Island, a part of the Lord Howe Rise in the Tasman Sea. This area serves as a resting and feeding ground for these whales during their migration between breeding and feeding grounds. The island and its surrounding waters are also a significant biodiversity hotspot, making it a crucial area for whale conservation. ")
              )
            )
          ),
          column(
            width = 4,
            h3("Best Viewing Spots"),
            tags$ul(
              tags$li("Malabar Hill"),
              tags$li("Kim's Lookout"),
              tags$li("Transit Hill"),
              tags$li("Boat tours around the island")
            ),
            hr(),
            h3("Whale Watching Season"),
            p("The whale watching season on Lord Howe Island typically runs from May to November, with the peak season generally between June and September. This is when Humpback whales are on their migration through the area. ")
          )
        )
      )
    )
  ),
  
  # 5. Ball's Pyramid Tab
  tabPanel(
    "Ball's Pyramid",
    fluidRow(
      column(
        width = 8,
        h2("Ball's Pyramid"),
        p("Ball's Pyramid is a remarkable sea stack located 20km southeast of Lord Howe Island."),
        hr(),
        fluidRow(
          column(
            width = 6,
            h3("History"),
            tags$img(src = "https://img.atlasobscura.com/Om4AI-3q6_n-sIVmuaH7X5WE0F0vQbqfVPhmZ8G0pik/rt:fit/w:1200/q:80/sm:1/scp:1/ar:1/aHR0cHM6Ly9hdGxh/cy1kZXYuczMuYW1h/em9uYXdzLmNvbS91/cGxvYWRzL3BsYWNl/X2ltYWdlcy84NWYw/MDI5ZC0yNjdkLTRh/MDMtOWM0Yi1lMGU1/MTg0OTExMmRlNzRi/M2Q4Mzk3ODc0OGY0/NTBfQmFsbHNfUHly/YW1pZCxfTG9yZF9I/b3dlX01hcmluZV9Q/YXJrXzEwMDguanBl/Zw.jpg", 
                     width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
            p("Ball's Pyramid is the world's tallest sea stack, located off the coast of Lord Howe Island in the South Pacific. It's a volcanic remnant, an eroded plug of a shield volcano that emerged from the sea about 7 million years ago. Named after Royal Navy Lieutenant Henry Lidgbird Ball, who first saw it in 1788, the pyramid is a striking natural wonder and a UNESCO World Heritage site. ")
          )
        ),
        hr(),
        h3("Climbing History"),
        tags$img(src = " https://i0.wp.com/www.museumoflost.com/wp-content/uploads/SMH17Feb65.jpg?resize=500%2C353&ssl=1", 
                 width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
        p("Ball's Pyramid was first climbed on 14 February 1965 by Bryden Allen, John Davis, Jack Pettigrew and David Witham of the Sydney Rock Climbing Club. Jack Hill of New Zealand then climbed to the summit with Pettigrew on the following day. Don Willcox and Ben Sandilands were part of the support team. This was after the first two missions failed due to rought tides preventing the sail team to make it on land. Then island is now protected as the peak is a nesting sigth for endagered boobie species and climbing it is prohibited."),
        hr(),
        h3("The Lord Howe Island Stick Insect"),
        tags$img(src = "https://therevelator.org/wp-content/uploads/2023/04/Lord-Howe-Island-stick-insect-1920.jpg", 
                 width = "100%", style = "border-radius: 8px; margin-top: 10px;"),
        p("Dryococelus australis, also known as the Lord Howe Island stick insect, Lord Howe Island phasmid or, locally, as the tree lobster, is a species of stick insect that lives in the Lord Howe Island Group. It is the only member of the monotypic genus Dryococelus. Thought to be extinct by 1920, it was rediscovered in 2001. Ther are an estimate of 20 to 30 individuals remaining on Balls Pyriamd. Since this are flightless land dwelling insects they will likely remain endemic to this island until their unfortunate extinction.")
      ),
      column(
        width = 4,
        h3("Quick Facts"),
        tags$ul(
          tags$li("Height: 562 meters"),
          tags$li("Distance from Lord Howe Island: 20km"),
          tags$li("Age: Approximately 7 million years"),
          tags$li("Composition: Volcanic rock"),
          tags$li("Status: Protected environmental sanctuary")
        )
      )
    )
  ),
  
  # 6. Population and Income Data Tab
  tabPanel(
    "Population & Income",
    fluidRow(
      column(
        width = 12,
        h2("Population and Income Data"),
        p("Below you'll find demographic and economic data for Lord Howe Island."),
        p("As of the 2021 Australian Census, Lord Howe Island had a permanent population of approximately 445 residents. The island's population has remained relatively stable over the years, with a slight increase to an estimated 448 in 2024 . To preserve its unique ecosystem and maintain a high quality of life, the island enforces a strict tourism cap, allowing only 400 visitors at any given time .
        
Economically, the island exhibits a relatively high income level. The median household income is $1,699 per week, and the median personal income stands at $961 per week, making it one of the highest in the Mid North Coast region of New South Wales . The local economy is predominantly driven by tourism-related industries, including accommodation and food services, as well as state government administration .

The island's commitment to conservation and sustainable living, coupled with its controlled tourism approach, contributes to its unique socio-economic profile, balancing economic activity with environmental preservation.")
      )
    ),
    hr(),
    fluidRow(
      column(
        width = 6,
        h3("Population Over Time"),
        plotlyOutput("populationPlot"),
        tags$img(src = "population_growth.png", width = "100%", style = "margin-bottom: 20px;")
      ),
      column(
        width = 6,
        h3("Income Distribution"),
        tags$img(src = "median_income.png", width = "100%", style = "margin-bottom: 20px;"),
        hr(),
        h3("Economic Sectors"),
        plotlyOutput("economicSectorsPlot"),
        tags$img(src = "Industry_of_Employment.png", width = "100%", style = "margin-bottom: 20px;"),
      )
    ),
    hr(),
    fluidRow(
      column(
        width = 12,
        h3("Detailed Population Data"),
        htmlOutput("populationTableHTML")
      )
    )
  )
)
# Server
server <- function(input, output, session) {
  # Location map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 159.0803, lat = -31.5546, zoom = 13) %>%
      addMarkers(
        lng = 159.0803, 
        lat = -31.5546, 
        popup = "Lord Howe Island"
      ) %>%
      addMarkers(
        lng = 159.0770, 
        lat = -31.5385, 
        popup = "Lord Howe Island Airport"
      ) %>%
      addCircles(
        lng = 159.0803, 
        lat = -31.5546, 
        radius = 5000, 
        color = "blue", 
        fillOpacity = 0.1
      )
  })
  output$populationTableHTML <- renderUI({
    includeHTML("WWW/population_data_table.html")
  })
}

# Run the application
shinyApp(ui = ui, server = server)