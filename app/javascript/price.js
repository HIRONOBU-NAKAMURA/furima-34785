function price() {
  const value = document.getElementById("item-price");
  value.addEventListener('input', () => {
    const taxValue = document.getElementById("add-tax-price");
    taxValue.innerHTML = Math.floor(value.value * 0.1)

    const profitValue = document.getElementById("profit");

    profitValue.innerHTML = Math.floor(value.value - (value.value * 0.1))
  })
}
window.addEventListener('load', price);
