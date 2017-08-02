module volumes_slice
using WeavePynb, LaTeXStrings

imgfile = "figures/michelin-man.jpg"
caption = """

Hey Michelin Man, how much does that costume weigh?

"""
michelin_man = gif_to_data(imgfile, caption)


end
