// synchronous [solidity]
// asynchronous [javascript]

//Promise can be Pending, Fulfilled, Rejected

async function main() {
  console.log("hi");
  let variable = 5;
  console.log(variable);
}

main();


main()
    .then(() => process.exit(0))
    .catch((error)) => {
        console.error(error);
        process.exit(1); 
    });
