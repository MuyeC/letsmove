module display_nft::display_nft;
use std::string;
use std::string::String;
use sui::display;
use sui::package;
use sui::tx_context::sender;


public struct GIT_NFT has key, store {
    id: UID,
    name: String,
    url: String
}

public struct DISPLAY_NFT has drop {}

fun init(otw: DISPLAY_NFT, ctx: &mut TxContext) {
    let keys = vector[
        utf8(b"name"),
        utf8(b"link"),
        utf8(b"image_url"),
        utf8(b"description"),
        utf8(b"project_url"),
        utf8(b"creator"),
    ];
    let values = vector[
        utf8(b"{name}"),
        utf8(b"https://testnet.suivision.xyz/object/{id}"),
        utf8(b"{url}"),
        utf8(b"a nft for git image"),
        utf8(b"https://testnet.suivision.xyz/"),
        utf8(b"recursionhs"),
    ];
    let publisher = package::claim(otw, ctx);
    let mut display = display::new_with_fields<GIT_NFT>(&publisher, keys, values, ctx);
    display::update_version(&mut display);

    transfer::transfer(publisher, sender(ctx));
    transfer::transfer(display, sender(ctx));

    let nft = GIT_NFT {
        id: object::new(ctx),
        name: string::utf8(b"RecursionHs input url NFT"),
        url: string::utf8(b"https://avatars.githubusercontent.com/u/36094328?v=4"),
    };
    }



}