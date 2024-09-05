// Base class for tools
export class BaseTool {
    name: string;
    description: string;

    constructor(name: string, description: string) {
        this.name = name;
        this.description = description;
    }

    // A method that could be overridden by subclasses or left as a placeholder
    async run(url: string): Promise<string> {
        throw new Error("Method 'run()' must be overridden.");
    }
}
