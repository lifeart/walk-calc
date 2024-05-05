const storageKey = `persisted`;

export function read(key: string, defaultValue: number): number {
  const accessKey = `${storageKey}/${key}`;
  try {
    return parseInt(
      localStorage.getItem(accessKey) ?? String(defaultValue),
      10,
    );
  } catch {
    return defaultValue;
  }
}
export function write(key: string, value: string) {
  const accessKey = `${storageKey}/${key}`;
  try {
    localStorage.setItem(accessKey, value);
  } catch (e) {
    // OOPS
  }
}
