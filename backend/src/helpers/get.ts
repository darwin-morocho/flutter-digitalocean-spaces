class _Get {
  private data: Map<string, any> = new Map();

  put<T>(dependency: T, key: string) {
    this.data.set(key, dependency);
  }

  find<T>(key: string): T {
    const inside = this.data.has(key);
    if (!inside) {
      throw new Error(`dependency ${key} not found`);
    }
    return this.data.get(key);
  }
}

const Get = new _Get();
export default Get;
