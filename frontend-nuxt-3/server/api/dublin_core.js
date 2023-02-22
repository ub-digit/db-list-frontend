export default defineEventHandler(async (event) => {
    const config = useRuntimeConfig();
    const query = getQuery(event);
    const res = await $fetch(config.API_BASE_URL + '/dublin_core', {params: query})
    return res;
})