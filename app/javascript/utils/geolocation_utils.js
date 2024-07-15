export const reverseGeocode = async (latitude, longitude) => {
  const url = `https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${latitude}&lon=${longitude}`;
  try {
    const response = await fetch(url);
    const data = await response.json();
    const address = data.display_name;
    return address;
  } catch (error) {
    console.error("Error during reverse geocoding:", error);
  }
};

export function getCurrentPosition() {
  navigator.geolocation.getCurrentPosition(
    (pos) => pos,
    (err) => err,
    options
  );
}
