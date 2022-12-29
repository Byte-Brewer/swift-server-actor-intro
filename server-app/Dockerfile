FROM swift:5.7-focal as build
WORKDIR /build
COPY . .
RUN swift package resolve
RUN swift build -c release -Xswiftc -g

# Run image
FROM ubuntu:focal
WORKDIR /run
COPY --from=build /build/.build/release /run
COPY --from=build /usr/lib/swift/ /usr/lib/swift/
COPY --from=build /build/Public /run/Public
ENTRYPOINT ["./Run"]