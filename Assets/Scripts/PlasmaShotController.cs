using UnityEngine;

public class PlasmaShotController : MonoBehaviour {
    public float plasmaDamage = 1f;
    private readonly string enemyTag = "Enemy";
    private ParticleSystem _particleSystem;
    private float lifeTime;
    private void Awake(){
        lifeTime = 5f;
        _particleSystem = GetComponent<ParticleSystem>();
    }

    private void OnEnable(){
        _particleSystem.Play();
        enabled = true;
    }

    private void OnDisable(){
        _particleSystem.Stop();
       Destroy(gameObject);
    }

    private void OnBecameInvisible(){
        Destroy(gameObject);
    }

    private void Update(){
        lifeTime -= Time.deltaTime;
        if (lifeTime <= 0f) {
            gameObject.SetActive(false);
            lifeTime = 5f;
        }
    }

   
private void OnTriggerEnter(Collider other){
        if (!other.gameObject.CompareTag(enemyTag)) return;
        other.gameObject.GetComponent<EnemyController>().TakeDamage(plasmaDamage);
        gameObject.SetActive(false);
    }
}