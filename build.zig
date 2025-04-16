const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib_mod = b.addModule("par_shapes", .{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .pic = true,
        .sanitize_c = false,
    });

    const lib = b.addLibrary(.{
        .name = "par_shapes",
        .root_module = lib_mod,
        .linkage = .static,
    });

    lib.addIncludePath(b.path("src"));
    lib.installHeadersDirectory(b.path("src"), "", .{});
    lib.addCSourceFile(.{ .file = b.path("src/par_shapes.c") });

    b.installArtifact(lib);
}
