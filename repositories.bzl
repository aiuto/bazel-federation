load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# WARNING: The following definitions are placeholders since none of the projects have been tested at the versions listed in this file.
# Please do not use them (yet). Future commits to this file will set the proper versions and ensure that all dependencies are correct.

# Repositories in this file have been tested with Bazel 0.26.0.

def bazel_buildtools_deps():
    bazel_skylib()
    rules_go()

def bazel_buildtools():
    bazel_buildtools_deps()
    maybe(
        http_archive,
        name = "com_github_bazelbuild_buildtools",
        strip_prefix = "buildtools-f27d1753c8b3210d9e87cdc9c45bc2739ae2c2db",
        url = "https://github.com/bazelbuild/buildtools/archive/f27d1753c8b3210d9e87cdc9c45bc2739ae2c2db.zip",
    )


def bazel_integration_testing_deps():
    pass  # TODO(fweikert): examine dependencies and add them, if necessary


def bazel_integration_testing():
    bazel_integration_testing_deps()
    maybe(
        http_archive,
        name = "build_bazel_integration_testing",
        url = "https://github.com/bazelbuild/bazel-integration-testing/archive/13a7d5112aaae5572544c609f364d430962784b1.zip",
        type = "zip",
        strip_prefix = "bazel-integration-testing-13a7d5112aaae5572544c609f364d430962784b1",
        sha256 = "8028ceaad3613404254d6b337f50dc52c0fe77522d0db897f093dd982c6e63ee",
    )

def bazel_toolchains_deps():
    pass # TODO(fweikert): examine dependencies and add them, if necessary

def bazel_toolchains():
    bazel_toolchains_deps()
    maybe(
        http_archive,
        name = "bazel_toolchains",
        sha256 = "5962fe677a43226c409316fcb321d668fc4b7fa97cb1f9ef45e7dc2676097b26",
        strip_prefix = "bazel-toolchains-be10bee3010494721f08a0fccd7f57411a1e773e",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-toolchains/archive/be10bee3010494721f08a0fccd7f57411a1e773e.tar.gz",
            "https://github.com/bazelbuild/bazel-toolchains/archive/be10bee3010494721f08a0fccd7f57411a1e773e.tar.gz",
        ],
    )

def bazel_skylib_deps():
    pass

def bazel_skylib():
    bazel_skylib_deps()
    maybe(
        http_archive,
        name = "bazel_skylib",
        url = "https://github.com/bazelbuild/bazel-skylib/releases/download/0.9.0/bazel_skylib-0.9.0.tar.gz",
        sha256 = "1dde365491125a3db70731e25658dfdd3bc5dbdfd11b840b3e987ecf043c7ca0",
    )
    # TODO(aiuto): We should be able to call bazel_skylib_setup() here.
    #     That would register the toolchains. We can not because you can
    #     not do the load() here.
    # load("@bazel_federation//setup:bazel_skylib.bzl", "bazel_skylib_setup")
    # bazel_skylib_setup()


def bazel_stardoc_deps():
    rules_nodejs()
    rules_sass()

def bazel_stardoc():
    # bazel_stardoc_deps()
    rules_java()
    maybe(
        http_archive,
        name = "io_bazel_skydoc",
        url = "https://github.com/bazelbuild/skydoc/archive/0.3.0.tar.gz",
        sha256 = "c2d66a0cc7e25d857e480409a8004fdf09072a1bd564d6824441ab2f96448eea",
        strip_prefix = "skydoc-0.3.0",
    )

# TODO(fweikert): delete this function if it's not needed by the protobuf project itself.
def protobuf_deps():
    # zlib()
    protobuf_javalite()

def protobuf():
    protobuf_deps()
    maybe(
        http_archive,
        name = "com_google_protobuf",
        sha256 = "b404fe166de66e9a5e6dab43dc637070f950cdba2a8a4c9ed9add354ed4f6525",
        strip_prefix = "protobuf-b4f193788c9f0f05d7e0879ea96cd738630e5d51",
        # Commit from 2019-05-15, update to protobuf 3.8 when available.
        url = "https://github.com/protocolbuffers/protobuf/archive/b4f193788c9f0f05d7e0879ea96cd738630e5d51.zip",
    )
    native.bind(name = "com_google_protobuf_cc", actual = "@com_google_protobuf")
    native.bind(name = "com_google_protobuf_java", actual = "@com_google_protobuf")

def protobuf_javalite_deps():
    pass

def protobuf_javalite():
    protobuf_javalite_deps()
    maybe(
        http_archive,
        name = "com_google_protobuf_javalite",
        strip_prefix = "protobuf-javalite",
        urls = ["https://github.com/protocolbuffers/protobuf/archive/javalite.zip"],
    )

def rules_cc_deps():
    bazel_skylib()

def XXrules_cc():
    rules_cc_deps()
    maybe(
        http_archive,
        name = "rules_cc",
        url = "https://github.com/bazelbuild/rules_cc/archive/624b5d59dfb45672d4239422fa1e3de1822ee110.zip",
        sha256 = "8c7e8bf24a2bf515713445199a677ee2336e1c487fa1da41037c6026de04bbc3",
        strip_prefix = "rules_cc-624b5d59dfb45672d4239422fa1e3de1822ee110",
        type = "zip",
    )

def rules_cc():
    bazel_skylib()
    maybe(
        http_archive,
        name = "rules_cc",
        url = "https://github.com/bazelbuild/rules_cc/archive/b7fe9697c0c76ab2fd431a891dbb9a6a32ed7c3e.zip",
        sha256 = "67412176974bfce3f4cf8bdaff39784a72ed709fc58def599d1f68710b58d68b",
        strip_prefix = "rules_cc-b7fe9697c0c76ab2fd431a891dbb9a6a32ed7c3e",
        type = "zip",
    )


# TODO(fweikert): check deps
def rules_go_deps():
    protobuf()
    org_golang_x_tools()
    org_golang_x_sys()

def rules_go():
    rules_go_deps()
    maybe(
        http_archive,
        name = "io_bazel_rules_go",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/0.18.6/rules_go-0.18.6.tar.gz",
            "https://github.com/bazelbuild/rules_go/releases/download/0.18.6/rules_go-0.18.6.tar.gz",
        ],
        sha256 = "f04d2373bcaf8aa09bccb08a98a57e721306c8f6043a2a0ee610fd6853dcde3d",
    )


def org_golang_x_tools():
    maybe(
        http_archive,
        name = "org_golang_x_tools",
        # master^1, as of 2018-11-02 (master is currently broken)
        urls = ["https://codeload.github.com/golang/tools/zip/92b943e6bff73e0dfe9e975d94043d8f31067b06"],
        strip_prefix = "tools-92b943e6bff73e0dfe9e975d94043d8f31067b06",
        type = "zip",
        patches = [
            "@io_bazel_rules_go//third_party:org_golang_x_tools-gazelle.patch",
            "@io_bazel_rules_go//third_party:org_golang_x_tools-extras.patch",
        ],
        patch_args = ["-p1"],
        # gazelle args: -go_prefix golang.org/x/tools
    )

def org_golang_x_sys():
    maybe(
        git_repository,
        name = "org_golang_x_sys",
        remote = "https://github.com/golang/sys",
        commit = "e4b3c5e9061176387e7cea65e4dc5853801f3fb7",  # master as of 2018-09-28
        patches = ["@io_bazel_rules_go//third_party:org_golang_x_sys-gazelle.patch"],
        patch_args = ["-p1"],
        # gazelle args: -go_prefix golang.org/x/sys
    )

def io_bazel_rules_go():
    org_golang_x_tools()
    org_golang_x_sys()
    http_archive(
        name = "io_bazel_rules_go",
        sha256 = "7be7dc01f1e0afdba6c8eb2b43d2fa01c743be1b9273ab1eaf6c233df078d705",
        urls = ["https://github.com/bazelbuild/rules_go/releases/download/0.16.5/rules_go-0.16.5.tar.gz"],
    )


def bazel_gazelle_deps():
    # TODO(fweikert): add all gazelle dependencies to the federation
    rules_go()

def bazel_gazelle():
    bazel_gazelle_deps()
    http_archive(
        name = "bazel_gazelle",
        sha256 = "7949fc6cc17b5b191103e97481cf8889217263acf52e00b560683413af204fcb",
        urls = ["https://github.com/bazelbuild/bazel-gazelle/releases/download/0.16.0/bazel-gazelle-0.16.0.tar.gz"],
    )


def com_github_bazelbuild_buildtools():
    http_archive(
        name = "com_github_bazelbuild_buildtools",
        strip_prefix = "buildtools-0.20.0",
        url = "https://github.com/bazelbuild/buildtools/archive/0.20.0.zip",
        sha256 = "7b46f95f1df24a62dbe1953cb7820f4170525f72b93a7f9fe414e027a3151128",
    )

def rules_java_deps():
    # TODO(aiuto): Java dependencies are currently brought in through
    # rules_java_setup(). As Java migrates from native to starlark, we should
    # bring in the dependencies in a formal way. Right now it churns too much.
    bazel_skylib()

def rules_java():
    rules_java_deps()
    maybe(
        http_archive,
        name = "rules_java",
        url = "https://github.com/bazelbuild/rules_java/archive/d7bf804c8731edd232cb061cb2a9fe003a85d8ee.zip",
        sha256 = "dc6b247b0bc61120e6c2bfe314c7ed5b19a3a5d5d3a3f8e9acf3ea8b4fb05c7b",
        strip_prefix = "rules_java-d7bf804c8731edd232cb061cb2a9fe003a85d8ee",
        type = "zip",
    )

def rules_nodejs_deps():
    pass

def rules_nodejs():
    rules_nodejs_deps()
    maybe(
        http_archive,
        name = "build_bazel_rules_nodejs",
        url = "https://github.com/bazelbuild/rules_nodejs/releases/download/0.30.1/rules_nodejs-0.30.1.tar.gz",
        sha256 = "abcf497e89cfc1d09132adfcd8c07526d026e162ae2cb681dcb896046417ce91",
    )


# The @federation markers are an experiment in how to pick up dependency stanzas
# from the rule sets. Each rule set should have a deps.bzl file. Inside those,
# there will be the @federation markers. Those must be designed so they can
# be extracted and dropped directly into this file, replacing the same stanza.

# @federation: BEGIN @rules_pkg
# TODO: ptr to where this was extracted from
# https://github.com/bazelbuild/rules_pkg/pkg/deps.bzl
def abseil_py():
    six_archive()
    maybe(
        http_archive,
        name = "abseil_py",
        urls = [
            "https://github.com/abseil/abseil-py/archive/pypi-v0.7.1.tar.gz",
        ],
        sha256 = "3d0f39e0920379ff1393de04b573bca3484d82a5f8b939e9e83b20b6106c9bbe",
        strip_prefix = "abseil-py-pypi-v0.7.1",
    )

def six_archive():
    maybe(
        http_archive,
        name = "six_archive",
        urls = [
            "http://mirror.bazel.build/pypi.python.org/packages/source/s/six/six-1.10.0.tar.gz",
            "https://pypi.python.org/packages/source/s/six/six-1.10.0.tar.gz",
        ],
        sha256 = "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a",
        strip_prefix = "six-1.10.0",
        build_file = "@abseil_py//third_party:six.BUILD"
    )


def rules_pkg_register_toolchains():
    pass


def rules_pkg():
    abseil_py()
    six_archive()
    maybe(
        http_archive,
        name = "rules_pkg",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/rules_pkg-0.2.1.tar.gz",
            "https://github.com/bazelbuild/rules_pkg/releases/download/0.2.1/rules_pkg-0.2.1.tar.gz",
        ],
        sha256 = "04c1eab736f508e94c297455915b6371432cbc4106765b5252b444d1656db051",
    )

# @federation: END @rules_pkg

def rules_python_deps():
    pass

def rules_python():
    rules_python_deps()
    maybe(
        http_archive,
        name = "rules_python",
        strip_prefix = "rules_python-fe5e0fa208f4fc4e469a960fe8c0d46394a21c21",
        url = "https://github.com/bazelbuild/rules_python/archive/fe5e0fa208f4fc4e469a960fe8c0d46394a21c21.tar.gz",
        sha256 = "59d82d1d8b21d37d3df9b92712487d8b055a39d77eaec569dff857ffcbc63971",
    )

def rules_rust_deps():
    bazel_skylib()

def rules_rust():
    rules_rust_deps()
    maybe(
        http_archive,
        name = "io_bazel_rules_rust",
        strip_prefix = "rules_rust-f32695dcd02d9a19e42b9eb7f29a24a8ceb2b858",
        url = "https://github.com/bazelbuild/rules_rust/archive/f32695dcd02d9a19e42b9eb7f29a24a8ceb2b858.tar.gz",
        sha256 = "ed0c81084bcc2bdcc98cfe56f384b20856840825f5e413e2b71809b61809fc87",
    )

def rules_sass_deps():
    bazel_skylib()
    rules_nodejs()

def rules_sass():
    rules_sass_deps()
    maybe(
        git_repository,
        name = "io_bazel_rules_sass",
        remote = "https://github.com/bazelbuild/rules_sass.git",
        commit = "8ccf4f1c351928b55d5dddf3672e3667f6978d60",
    )

def rules_scala_deps():
    bazel_skylib()

def rules_scala():
    rules_scala_deps()
    maybe(
        http_archive,
        name = "io_bazel_rules_scala",
        strip_prefix = "rules_scala-300b4369a0a56d9e590d9fea8a73c3913d758e12",
        type = "zip",
        # commit from 2019-05-27
        url = "https://github.com/bazelbuild/rules_scala/archive/300b4369a0a56d9e590d9fea8a73c3913d758e12.zip",
        sha256 = "7f35ee7d96b22f6139b81da3a8ba5fb816e1803ed097f7295b85b7a56e4401c7",
    )

def io_bazel_rules_scala():
    bazel_skylib()
    http_archive(
        name = "io_bazel_rules_scala",
        strip_prefix = "rules_scala-300b4369a0a56d9e590d9fea8a73c3913d758e12",
        type = "zip",
        # commit from 2019-05-27
        url = "https://github.com/bazelbuild/rules_scala/archive/300b4369a0a56d9e590d9fea8a73c3913d758e12.zip",
        sha256 = "7f35ee7d96b22f6139b81da3a8ba5fb816e1803ed097f7295b85b7a56e4401c7",
    )
