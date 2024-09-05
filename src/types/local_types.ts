export type QA = {
    question: string;
    answer?: string;
}

export type ConfigI = {
	host: string;
	port: number;
	txNewOpenAiApi: string; 
  };
  
  export type DaoTemplate = {
	deployer: string;
	projectName: string;
	addresses: Array<string>;
	tokenName?: string;
	tokenSymbol?: string;
	tokenUrl?: string;
  }
  