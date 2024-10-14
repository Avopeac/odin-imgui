package main

import "core:fmt"
import "core:log"

import imgui "../.."
import imwin32 "../../impl/win32"
import imdx12 "../../impl/dx12"

main :: proc() {

    logger_opts := log.Options {
        .Level,
        .Line,
        .Procedure,
    };
    context.logger = log.create_console_logger(opt = logger_opts);

    log.info("Starting D3D12 Example...");
}