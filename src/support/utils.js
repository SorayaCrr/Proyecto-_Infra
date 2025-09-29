module.exports = {
    getFechaActual() {
        const fecha = new Date();
        return fecha.toISOString().slice(0, 19).replace("T", " ");
    }
}