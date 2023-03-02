import {ChakraProvider, DarkMode} from "@chakra-ui/react";
import {darkTheme, RainbowKitProvider} from "@rainbow-me/rainbowkit";
import "@rainbow-me/rainbowkit/styles.css";
import {env} from "@shared/environment";
import {chains, wagmiClient} from "@shared/wagmiClient";
import type {AppProps} from "next/app";
import Head from "next/head";
import Router from "next/router";
import NProgress from "nprogress";
import {WagmiConfig} from "wagmi";

// Router Loading Animation with @tanem/react-nprogress
Router.events.on("routeChangeStart", () => NProgress.start());
Router.events.on("routeChangeComplete", () => NProgress.done());
Router.events.on("routeChangeError", () => NProgress.done());

function MyApp({Component, pageProps}: AppProps) {
    return (
        <>
            <Head>
                <meta name="viewport" content="initial-scale=1.0, width=device-width"/>
            </Head>

            <ChakraProvider>
                <DarkMode>

                    <WagmiConfig client={wagmiClient}>
                        <RainbowKitProvider
                            chains={chains}
                            theme={darkTheme()}
                            coolMode={true}
                        >

                            <Component {...pageProps} />

                        </RainbowKitProvider>
                    </WagmiConfig>

                </DarkMode>
            </ChakraProvider>
        </>
    );
}

export default MyApp;
