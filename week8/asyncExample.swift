import Foundation

// function that simulates fetching data from a remote server with async/await
func fetchData() async -> String {
    print("starting data fetch...")

    // simulate network delay using Task.sleep()
    try? await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds

    print("data fetch complete!")
    return "fetched data successfully!"
}

// function that simulates making multiple async calls
func fetchMultipleData() async {
    async let firstFetch = fetchData()
    async let secondFetch = fetchData()

    // waits for both tasks to finish concurrently
    let results = await [firstFetch, secondFetch]
    print("all data fetched:", results)
}

// entry point: calling async function from main
func runAsyncOperations() {
    Task {
        await fetchMultipleData()
    }
}

// start the async operations
runAsyncOperations()
